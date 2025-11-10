Return-Path: <linux-kernel+bounces-894187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 160AAC49700
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 22:42:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4A1154EB07B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 21:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6F15330B1F;
	Mon, 10 Nov 2025 21:42:32 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E7932D0D0;
	Mon, 10 Nov 2025 21:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762810952; cv=none; b=JpS0obw1DAy8FUrhuEgJWI/ALk6tNa/17tqVfk8QDTDCyfnOz0QkjSvnQ+pEor/K/743MCkuwfUmn7G3fTFodrDmPdlineRx/zEKS1g/Su7gToNZ2C8myPv25+mF6qYfPAG7aNr9t9QezUeahbdHTnsYN/7A8ntsWljbndt8WC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762810952; c=relaxed/simple;
	bh=bEMecNnSn17jv7cTIq3jiwYCG+i/vl1OcQ33XG4OFmw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=svdsnibg3Iq2xQ7Tlx4fP11km+aIYrZKkHpNrB+ZYKjTENnGiigaKfS8Yjn6xhsBx2TwrWz4SO7bJLnT2Jz3Du6AB28NbrN3BDUrrFj3Clehx6L9X2kFXDc2QkG97BVU4MRDnJCqgfqbc3Udo2Yp9bYpPo5cHWEYwajaqKhryiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf10.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id A8D981402DB;
	Mon, 10 Nov 2025 21:42:20 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf10.hostedemail.com (Postfix) with ESMTPA id CF6B23D;
	Mon, 10 Nov 2025 21:42:16 +0000 (UTC)
Date: Mon, 10 Nov 2025 16:42:25 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Linus Torvalds  <torvalds@linux-foundation.org>, "H. Peter Anvin"
 <hpa@zytor.com>, Mike Rapoport <rppt@kernel.org>, Laurent Pinchart
 <laurent.pinchart@ideasonboard.com>, Christian Brauner
 <brauner@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Vlastimil
 Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
 "workflows@vger.kernel.org" <workflows@vger.kernel.org>,
 "ksummit@lists.linux.dev" <ksummit@lists.linux.dev>, Dan Williams
 <dan.j.williams@intel.com>, Theodore Ts'o <tytso@mit.edu>, Sasha Levin
 <sashal@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Kees Cook
 <kees@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Miguel
 Ojeda <ojeda@kernel.org>, Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH] [v2] Documentation: Provide guidelines for
 tool-generated content
Message-ID: <20251110164225.4b343fe4@gandalf.local.home>
In-Reply-To: <21622a5393ef21413cae91d9c8ebbb8425d2c193.camel@HansenPartnership.com>
References: <20251105231514.3167738-1-dave.hansen@linux.intel.com>
	<653b4187-ec4f-4f5d-ae76-d37f46070cb4@suse.cz>
	<20251110-weiht-etablieren-39e7b63ef76d@brauner>
	<20251110172507.GA21641@pendragon.ideasonboard.com>
	<CAHk-=wgEPve=BO=SOmgEOd4kv76bSbm0jWFzRzcs4Y7EedpgfA@mail.gmail.com>
	<aRIxYkjX7EzalSoI@kernel.org>
	<CAHk-=wir-u3so=9NiFgG+bWfZHakc47iNy9vZXmSNWSZ+=Ue8g@mail.gmail.com>
	<A274AB1C-8B6B-4004-A2BC-D540260A5771@zytor.com>
	<CAHk-=whczwG=+-sAzoWoTY_VOwdFH3b5AkvQbgh+z98=p1iaXA@mail.gmail.com>
	<20251110145405.5bc87cc5@gandalf.local.home>
	<21622a5393ef21413cae91d9c8ebbb8425d2c193.camel@HansenPartnership.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: CF6B23D
X-Stat-Signature: k5khmrtfujf73rxgntbx88bta6khh6xm
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19kHQg4PhuLSvsNRpbb/5go1uqnOhExorY=
X-HE-Tag: 1762810936-865393
X-HE-Meta: U2FsdGVkX1/hK87wS1/f9ot42991ei4U3afomqi2EElZYt94AGJZkJZqoXUWmioYnyqGg9JwbQlANwAhDmEmKi5xyGcDjjXqKlHMMcrZVekvMTeom/8vU6aIyz192JQ6+o8jPQsQAjqFN0V2QuXsdPxuhuw4cHU6KQnUiqcPrWM/WytQk+ovlNkBQpTbQludKHeI5F+BkwM/WHAwzQ/eZYq/HMxpTpRp4ljc70YodhTxeCMlBLrAJ9MMYXlnRSGkRKwJv2bM2exezTFGODWtuaFWpNc6aey+I6TtkxtYY7VaK+b49jrZb2/TgW3wtaEjUNPquKgJ4k3m9FjIdJO1Mfe59fuyUFC2NzyRmjFUeePL+W61zuHBC0vozBi+XkV9

On Mon, 10 Nov 2025 16:21:30 -0500
James Bottomley <James.Bottomley@HansenPartnership.com> wrote:

> As far as the copyright status of AI output in the US goes, as long as
> its not derivative of something, then it's a non-human creation and as
> such cannot be copyrighted at all, so it's equivalent to public domain.

I believe that's what is currently being argued in court. If AI is trained
on human content and prints out something based on it, is it a non-human
creation?  This isn't a case of a monkey taking a selfie, where the content
provider is clearly non-human. This is a machine that uses human created
content to derive new creations.

-- Steve

