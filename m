Return-Path: <linux-kernel+bounces-872013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E067C0F1C5
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 16:59:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3423407821
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 15:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2974D3191D0;
	Mon, 27 Oct 2025 15:45:21 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418433164D3
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 15:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761579920; cv=none; b=BC6IlOAV/Nx7c9QvJK+UhaSvCNKJEK5BhCsBtVNaLZjxiujcKXShaKfnTM++gb8XPe+JFmd45Lhc8ukIk7ftEfZfGmti4v6NbnCaL4JKNFBSdvLxMQ1Ou3/wNEnJH3S8tGBhuuqPY53LFccqFG3IojWl0KlPjVSlOrROrnmsFlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761579920; c=relaxed/simple;
	bh=Ips81UNHQeAq7E5Rs9d1fFKA3vURdlckpWHsB5DgE2k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=k9hgVd/8NTSrdkjCcmLfLazRaDLpuSNqUtBvubpA3B4HlQcZ2k55NoBTDj/4yQIRBoeHRD7qzpCN0lEHSleg/fAZ13A/p13borzB5JpG1SRkQn4hS2Q6ladTbf9Lara0Z1nR9S6NbMNsh9IdjwS6/gyrPmrHNdbQ3KT8or8Aqwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com; spf=pass smtp.mailfrom=perches.com; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf19.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 53B891299B2;
	Mon, 27 Oct 2025 15:45:11 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf19.hostedemail.com (Postfix) with ESMTPA id 2FF5720028;
	Mon, 27 Oct 2025 15:45:09 +0000 (UTC)
Message-ID: <4484f1dfe22c9ca6dcad52d915a92f600d0088e1.camel@perches.com>
Subject: Re: [PATCH v3 1/1] checkpatch: Don't warn on "orhapned" DT schema
 file
From: Joe Perches <joe@perches.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	linux-kernel@vger.kernel.org
Cc: Andy Whitcroft <apw@canonical.com>, Dwaipayan Ray
 <dwaipayanray1@gmail.com>,  Lukas Bulwahn <lukas.bulwahn@gmail.com>,
 Akhilesh Patil <akhilesh@ee.iitb.ac.in>
Date: Mon, 27 Oct 2025 08:45:08 -0700
In-Reply-To: <20251027093818.1806010-1-andriy.shevchenko@linux.intel.com>
References: <20251027093818.1806010-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 2FF5720028
X-Stat-Signature: qas7hfqaxdnz84haphxjm7cwhfpb4553
X-Rspamd-Server: rspamout06
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX198wwacD3y2LBkpyPlYL0HGwOlRhncclvQ=
X-HE-Tag: 1761579909-979015
X-HE-Meta: U2FsdGVkX1+zInxPIGHxRBZoHkDQrj1+F1E+sTi6N39gKkSJnoYNyXdejWyPaSfUDImXDbRxemXAEcYFa/YTihS0Z32neWFV0L5DmKp2SOenHrjbUIG1o6ME+uVAlgGXDSTE9KXtG6+9ebQg1a18a4xRYSkYtULsfJ8Fmot9kzG67Xi57PxnRPV8SC4M4cXSrA+QEn1vppE9RMt7Djt6vLZjo70HNV6fUiqvi36+KL1y5Aaffhypjpr6m+O8hspeLu1InjuruPEEV+nA6icgLGV5qzgucGkcn8XsDEbQhZnqRDhVuvAil6gqfzgQg7jaBQjrXeJ6j5zraDdoAT/WXGNuRhmQD3sop+WCtpsQKFwJVixn+tB1sA==

On Mon, 2025-10-27 at 10:36 +0100, Andy Shevchenko wrote:
> Currently checkpatch warns is the DT schema file is absent in MAINTAINERS=
.
> However the DT schema files are self-contained in this sense and
> have embedded information about maintainers of it. This is a requirement.
> Hence, avoid checkpatch warning about it.
>=20
> Tested-by: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

nackish.

Perhaps it'd be better to make checkpatch and get_maintainer have
some list of filename suffixes that are expected to have embedded
maintainer email addresses

Maybe something like:

our $maintainer_in_file_types =3D '\.(?:yaml|dts.?|rst)$';


