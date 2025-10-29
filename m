Return-Path: <linux-kernel+bounces-876891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E9FC1CB90
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 19:14:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64F815657BB
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 18:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F5BA2FABEE;
	Wed, 29 Oct 2025 18:03:24 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C1C273D9A
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 18:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761761003; cv=none; b=TtkN1oER36A5rb7bA1YEVHZp0wcvFYQ8q5D7qN59vepZRzmPbXHYRGF3CJg34NF0jNxEYCqpqvi9MX8yLhk+RBSGyIl7I13yG78LaTryjlc7mQGRXCarlp+raD5nEsOJbdOnFXovixN9SDL7+ota+yt3wgT1sUDe1itAykcsv5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761761003; c=relaxed/simple;
	bh=0DhNQvS/wj4N35CJKIOfX1w88jcHmNnTT/ePHi8SEZI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eHdVbKciprwP/RYiKCriI9AaoMhXLbuMCeoM6FwIlFP4KLn+QUAQy19iAimui8TZXdWU2o8GFsXHBeCmV2WrV6Hl2APLFH+z2lMpE4pV92u80Wtcykt5H/euH86zKVJBdjNo1XaD1HPv9sg6OujtSnPJ8uIBEXKLkLx+A4edJJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf20.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 9F8CA1A05DE;
	Wed, 29 Oct 2025 18:03:14 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf20.hostedemail.com (Postfix) with ESMTPA id C513C20028;
	Wed, 29 Oct 2025 18:03:12 +0000 (UTC)
Date: Wed, 29 Oct 2025 14:03:53 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>, Jakub Kicinski
 <kuba@kernel.org>, Jacob Keller <jacob.e.keller@intel.com>,
 linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH] scripts: add tracepoint-update to .gitignore
Message-ID: <20251029140353.58a4d6dd@gandalf.local.home>
In-Reply-To: <20251029175720.12998-1-ansuelsmth@gmail.com>
References: <20251029175720.12998-1-ansuelsmth@gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: hh53eeyx46t6xcwosxbxxgrohuhsimdi
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: C513C20028
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19P3xqApsh0BRdYXoPUIuu/U3yG7wfK2cY=
X-HE-Tag: 1761760992-73358
X-HE-Meta: U2FsdGVkX197qUwp0UcIWDJVnFQ7VN/B739EgZeBLETSaGHiOhJeP+TUXyMDuEmFcHRSCtG+atsd5ebtRmjWGqywnJyI3z6fGAj/KzAQKN3sogYeFBlQ000pi18vEW4Zon3kboBi8qnMk1nQ6IJ02Yf/yugjtliOOGmJrIVZi1m9aLM95t4sY1i1yc9rolTtGaywIAt7qVIXPKiaQ2IVTr55bXTS793Scs8D22wqmBdRzxp/LOl/TiIr+JUBmiSLJrilt+KTPoHRyOEZHwqyzxnxg1CuxlrABqRGGthDs+qULdJMPgsKsz5V8L4zL9SmZUfJ3VDtj24pgLIPg8VPui4cYc5GZgpmdZnjfJmjDEJKd27OMlWEbA==

On Wed, 29 Oct 2025 18:57:18 +0100
Christian Marangi <ansuelsmth@gmail.com> wrote:

> New tracepoint-update tool is not ignored from git when built.
> 
> Add it to scripts .gitignore to prevent including files in commits by
> mistake (for use that have the bad habits of using git add .).

Bartosz beat you to it:

  https://lore.kernel.org/all/20251029120709.24669-1-brgl@bgdev.pl/

I already applied the patch and pushed it to my for-next branch. It will
likely be in linux-next by tomorrow.

-- Steve

