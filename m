Return-Path: <linux-kernel+bounces-859346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF6ABED568
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 19:32:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F33E19A77C2
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 17:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9E0525A659;
	Sat, 18 Oct 2025 17:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oDGhkZ/3"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D55516F288;
	Sat, 18 Oct 2025 17:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760808765; cv=none; b=DQCpYqB6gaHm9v/ENgB4qzTGCcWt/0iJCm4c0wE73nnwfLogmqOLrdhI0nsbZcX5k77TqMJ5UJ+EUfnT0KXTEB5SfSpMJQ1pYRxVutxSKu8DlQII6sppV7qNKJQpzFhKRxFBfvz8H+ZALYnJZYnwpc1Dh694hIzupPjyLLUnH24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760808765; c=relaxed/simple;
	bh=qlpQysAtLjPPuAYZ6sv95mF/8IWgUqrTAOsaiQyTKcA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pancImxg1Vq9ZQXT8kSyJpyzO6BSehrPImlTmJHuJlyJzIIsti5coZIk0iL2dh7lDc8F/62eD8qX4Yk+KzqoYQ2WNeJmOzwu0xyIoZIH8VWBDhdw276Ls3xOR69kjLN2PDOVgtsvyKliXDoHLXohoA25a6B8EARi/5qJnxjJztQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oDGhkZ/3; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760808763; x=1792344763;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=qlpQysAtLjPPuAYZ6sv95mF/8IWgUqrTAOsaiQyTKcA=;
  b=oDGhkZ/3VLPO+zQg5BZCWS+kpcvh3eOU6SBEdQuW34HdwbfUkioBzhYX
   6eDjQGhZK7TFwKR3IOab6uvFtYUhqlGNX6O5J6p1PQW9LJI+oqfHIMuwF
   WMC5+31aZIqToZYdsClZdJgolCPJMB/sgidc51NmmG73gFwrlqPSw1U1r
   28wIvGEBQztHLk315Wgrtg1TVC/qzyjnXTcawwXeXG5MeoowQdLA8vEkQ
   fR5IETa4e5TCvQ4Geg87qONTXx7LSI3p56+Luf10fBj4EGKcoXHgyKLoL
   qvTyIqHA9YDFrk1WJKstLKja/rGI6OZsGPDgjWX2uXF7zyS8Jjqu5cV8d
   A==;
X-CSE-ConnectionGUID: fQa55HwCScShkpdTlmL1+g==
X-CSE-MsgGUID: BbWVGR17SMqnEpZhoY1o8Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="73670177"
X-IronPort-AV: E=Sophos;i="6.19,239,1754982000"; 
   d="scan'208";a="73670177"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2025 10:32:42 -0700
X-CSE-ConnectionGUID: 8aq9F9SlRYu5dgklS0iwnQ==
X-CSE-MsgGUID: o/yGeldTQnGCOKW0QObD2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,239,1754982000"; 
   d="scan'208";a="220131692"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.244.194])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2025 10:32:41 -0700
Received: from andy by ashevche-desk with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1v935F-00000000L8i-2abO;
	Wed, 15 Oct 2025 18:06:33 +0300
Date: Wed, 15 Oct 2025 18:06:33 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: luke@ljones.dev,
	"Mario Limonciello (AMD) (kernel.org)" <superm1@kernel.org>,
	Corentin Chary <corentin.chary@gmail.com>,
	Hans de Goede <hansg@kernel.org>,
	Denis Benato <benato.denis96@gmail.com>,
	LKML <linux-kernel@vger.kernel.org>,
	platform-driver-x86@vger.kernel.org, Armin Wolf <W_Armin@gmx.de>
Subject: Re: [PATCH] MAINTAINERS: add Denis Benato as maintainer for asus
 notebooks
Message-ID: <aO-4ebdTkIoUgBO8@smile.fi.intel.com>
References: <20251003184949.1083030-1-benato.denis96@gmail.com>
 <46762a7e-e8cb-45fb-8d62-062915133463@kernel.org>
 <36720829-6ba3-4178-952c-4236622edfa2@kernel.org>
 <ebe38602-1832-391f-b043-cae0c10d7e30@linux.intel.com>
 <E7993E86-3805-4E93-A714-0D4A33FBA759@ljones.dev>
 <7c741d8d-dc07-7316-3999-cd69f2af67a3@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7c741d8d-dc07-7316-3999-cd69f2af67a3@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Oct 06, 2025 at 12:12:12PM +0300, Ilpo Järvinen wrote:
> On Mon, 6 Oct 2025, luke@ljones.dev wrote:

...

> My opinion is we remove that address, there's little point in keeping 
> people around when they've stopped communicating years ago. For this 
> driver it's easy, but that address also appears for samsung-laptop.c
> which doesn't have another maintainer.

The latter case should also switch to Orphaned or get removed the whole
MAINTAINERS record for it.

But before doing that have you checked `git log --grep'$First $Last'` (i.e. w/o
email) to see if there is any new activity? Also any other emails available
from googling / duckduckgo'ing?


-- 
With Best Regards,
Andy Shevchenko



