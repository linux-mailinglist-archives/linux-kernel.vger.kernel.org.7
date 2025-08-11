Return-Path: <linux-kernel+bounces-762127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42189B2026D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 10:57:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B646162E91
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 08:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33E462DC34C;
	Mon, 11 Aug 2025 08:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lTJf325g"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A512D9EC2
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 08:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754902661; cv=none; b=qA0vNbBcEOg0hvmQsYS6wFbbQ2CR9Pq41h5jreHRrDZIizQMh9C0H13Qdlx3RzWgF2WzUT/D8DCc2D77ZlyUmO9ppcE9IxHyacsE+n0HNJxZNewTW5vWrbmQRceEUmSDr/EGRHQ1ruosOnmD3zLN47MJtPsFT897DBvoKZjF83o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754902661; c=relaxed/simple;
	bh=Es74pyv8jA4LngoN7zFoBuyVwvPcypUYy8xm7FSRTM8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Hsxlvxr5WgKUb22PALpdMnq+FEBYItca/zTHy3XCc1sa9MstiQ75C9zG16C58KsGORz+0kp2mcyaznNx83Wgyrqphb7OCljU2cONi6dSvZHbRpDqy4unzHxQN0NoofkJ/sQLH6NKFTY04zGSQCclEG3agy6LwcDSOir+3GEnH7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lTJf325g; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754902659; x=1786438659;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Es74pyv8jA4LngoN7zFoBuyVwvPcypUYy8xm7FSRTM8=;
  b=lTJf325grH1zyskuhbnDSz9vNOqValn3/uos3tpC6mcjA9vIgoT+0yMH
   NS9HBIj4lF58tDDSa/kkJeNLSUoYVrxUkGuqTYnqP/aJalUEyuIppbee3
   56DuzWMMTiYK/niQXZBrj3bsT2KmyBGx2xmoOknWpxxfu93mvPOLgUO0d
   fsjFc2/WcFY3DyPJUaOTwOcEuP5JOQNRN7FhIiPYpeeHEjoFvmutxOE+Q
   dyyTPrJCMGN+6o74ZQvU+XsI8yuMrFK1+Zzfy9kBdVonj7ilUeFzCprro
   1xPMpaDNKQJO8FL+G6wsNo5tO61dvZGklyBKyYU7TxnoslOYg3xPvehOo
   Q==;
X-CSE-ConnectionGUID: cTxbAwfLR+qOcrm4Pb1erg==
X-CSE-MsgGUID: PIgTFRfJQQOFS5crAs1BxQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11518"; a="56863114"
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="56863114"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 01:57:36 -0700
X-CSE-ConnectionGUID: Hh0pKwf0QyyDIzbkPjyGxw==
X-CSE-MsgGUID: iVwfg5aoT4CV1HaqnFyv7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="196698738"
Received: from sschumil-mobl2.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.244.87])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 01:57:34 -0700
Received: from punajuuri.localdomain (unknown [192.168.240.130])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 484DB11F87A;
	Mon, 11 Aug 2025 11:57:32 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.96)
	(envelope-from <sakari.ailus@linux.intel.com>)
	id 1ulOLU-008spR-0a;
	Mon, 11 Aug 2025 11:57:32 +0300
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: linux-kernel@vger.kernel.org
Cc: Andy Whitcroft <apw@canonical.com>,
	Joe Perches <joe@perches.com>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 1/1] checkpatch: Deprecate container_of() in favour of container_of_const()
Date: Mon, 11 Aug 2025 11:57:31 +0300
Message-Id: <20250811085731.2117377-1-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

container_of() discards constness of its first argument and thus its use
may result in inadvertly unconstifying an object that is const. While
container_of_const() addresses this problem, the vast majority of new uses
of the two use the container_of() variant lacking the check.

Stem the flow of new container_of() use by adding it to the list of
deprecated functions in scripts/checkpatch.pl. Once all existing
container_of() users have been fixed to respect the constness attribute,
the check can be added to container_of() and we can switch back to
container_of() again.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 scripts/checkpatch.pl | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 664f7b7a622c..32edebfc1935 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -859,6 +859,7 @@ our %deprecated_apis = (
 	"kunmap_atomic"				=> "kunmap_local",
 	"srcu_read_lock_lite"			=> "srcu_read_lock_fast",
 	"srcu_read_unlock_lite"			=> "srcu_read_unlock_fast",
+	"container_of"				=> "container_of_const",
 );
 
 #Create a search pattern for all these strings to speed up a loop below
-- 
2.39.5


