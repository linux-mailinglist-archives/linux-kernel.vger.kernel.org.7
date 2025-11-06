Return-Path: <linux-kernel+bounces-888009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B94B3C39915
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 09:25:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AB7D3B8999
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 08:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51C714CB5B;
	Thu,  6 Nov 2025 08:24:39 +0000 (UTC)
Received: from mail.eskimo.com (mail.eskimo.com [66.114.134.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950A3280332
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 08:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.114.134.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762417478; cv=none; b=S6+yGwAf1Hu/zR68lbPNV5lULUN//MX7AFHjp9e8QImDzCHhBdlv7i85ttDvuAF4yHF0uF6hNve4DVYVly3liIVKEJOQWKOPhEaZpUNb8SxyUYf/kLG2Xyj2bM5IWd8g2kFxmJtnKp2gFnGnIrCkgsWHYXVl128S5BYMQ5iBmD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762417478; c=relaxed/simple;
	bh=0bt/+bzPQja/RyBnPkVvPYY1fH2Dovr77qH8J3ldAV0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=LJuCfMF0AObGnTsUMnDnOnly+gngBepFZazT8pRKAF+q81EeNbwrNYgIw1Qey6WaCjCcIuPwxUAoPPgVffm6TdKkCjd2WrIGxIhjQvovoq9vaveLZwBvtlrH1xIGbFb51jYIMacFks/OcUvDt++rihIKqjnjuIRsM5xpCBezJRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=eskimo.com; spf=pass smtp.mailfrom=eskimo.com; arc=none smtp.client-ip=66.114.134.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=eskimo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eskimo.com
Received: from ubuntu.eskimo.com (ubuntu.eskimo.com [IPv6:2001:560:4407:1::106])
	by mail.eskimo.com (Postfix) with ESMTPS id 10A2E3C1BE1;
	Thu,  6 Nov 2025 00:24:37 -0800 (PST)
Date: Thu, 6 Nov 2025 00:24:36 -0800 (PST)
From: Robert Dinse <nanook@eskimo.com>
To: Michal Hocko <mhocko@suse.com>
cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: Folio Related Stability Crashes in 6.17.5 and 6.17.6
In-Reply-To: <aQxX1HdOnVZJAERp@tiehlicka>
Message-ID: <41d1cb48-7711-690e-c9a2-978e0f96f5d6@eskimo.com>
References: <b964df0f-45e3-4fea-a84d-852869b49502@eskimo.com> <aQxX1HdOnVZJAERp@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="1916979846-979605391-1762417477=:3951505"
X-Virus-Scanned: clamav-milter 1.4.3 at mail.eskimo.com
X-Virus-Status: Clean

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1916979846-979605391-1762417477=:3951505
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT


      I am installing 6.17.7 presently, I was a little resident to install the 
current tree on a critical machine.  If need be I will.  Also, I do have a 
crash dump on the last failure if that would be of any help.

-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-
  Eskimo North Linux Friendly Internet Access, Shell Accounts, and Hosting.
    Knowledgeable human assistance, not telephone trees or script readers.
  See our web site: http://www.eskimo.com/ (206) 812-0051 or (800) 246-6874.

On Thu, 6 Nov 2025, Michal Hocko wrote:

> Date: Thu, 6 Nov 2025 09:09:56 +0100
> From: Michal Hocko <mhocko@suse.com>
> To: Robert Dinse <nanook@eskimo.com>
> Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
> Subject: Re: Folio Related Stability Crashes in 6.17.5 and 6.17.6
> 
> On Wed 05-11-25 19:19:17, Robert Dinse wrote:
>>       Since 6.17.5 I have twice had one of my servers lock up in a state
>> where it still routed network traffic and responded to pings but no user
>> programs are running.
>
> Can you reproduce with the current Linus tree?
> -- 
> Michal Hocko
> SUSE Labs
>
--1916979846-979605391-1762417477=:3951505--

