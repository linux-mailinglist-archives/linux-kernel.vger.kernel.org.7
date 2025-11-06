Return-Path: <linux-kernel+bounces-888118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64707C39E0D
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 10:46:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E55001A40944
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 09:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A2BF30DD06;
	Thu,  6 Nov 2025 09:44:01 +0000 (UTC)
Received: from mail.eskimo.com (mail.eskimo.com [66.114.134.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4290130C611
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 09:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.114.134.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762422240; cv=none; b=Yd0DwltQUHhscCWPUDM+s6iYnzTla/uYWJwajOgQhWPctGNg0KKRyamEzK/WdDUpRxV6qQG7EHIH8JZankLHlauEFX+Dob8Em+TRRUgct4hzj+WXDDLt8K5Ts9oWQfcw64cWtvHSgc4m6hJnoHoRzQ+uYEqbjrEP2y2lQbXMPew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762422240; c=relaxed/simple;
	bh=WgmGG4azgf9SNTjggOZV3foJuIf6JXYTefpUY7MRUdY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=XdaZcS1XnEMnlgoVIgni52as8B56xnWE2cIFhnVhoHoUXJ9269G84vEXu9Ve9gBQUwmCLk66jMlxOUaspd7c+USSmNpKgwkCElyhsWxdc3EQZ3i2cpcGz93ubxPTp2xQ0W1Kr1CaHZvTixJOXpsC3NF0yaMIfvQyHd18OfavqDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=eskimo.com; spf=pass smtp.mailfrom=eskimo.com; arc=none smtp.client-ip=66.114.134.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=eskimo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eskimo.com
Received: from ubuntu.eskimo.com (ubuntu.eskimo.com [IPv6:2001:560:4407:1::106])
	by mail.eskimo.com (Postfix) with ESMTPS id B94553C2AC3;
	Thu,  6 Nov 2025 01:43:58 -0800 (PST)
Date: Thu, 6 Nov 2025 01:43:58 -0800 (PST)
From: Robert Dinse <nanook@eskimo.com>
To: Michal Hocko <mhocko@suse.com>
cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: Folio Related Stability Crashes in 6.17.5 and 6.17.6
In-Reply-To: <aQxl1sXTvhIB753a@tiehlicka>
Message-ID: <806cfd1f-df36-5d75-d318-3bc604479bcd@eskimo.com>
References: <b964df0f-45e3-4fea-a84d-852869b49502@eskimo.com> <aQxX1HdOnVZJAERp@tiehlicka> <41d1cb48-7711-690e-c9a2-978e0f96f5d6@eskimo.com> <aQxl1sXTvhIB753a@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Virus-Scanned: clamav-milter 1.4.3 at mail.eskimo.com
X-Virus-Status: Clean


Ok, I will wait and see if this manifests in 6.17.7, if so I will install
from the git tree to further follow-up.

-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-
  Eskimo North Linux Friendly Internet Access, Shell Accounts, and Hosting.
    Knowledgeable human assistance, not telephone trees or script readers.
  See our web site: http://www.eskimo.com/ (206) 812-0051 or (800) 246-6874.

On Thu, 6 Nov 2025, Michal Hocko wrote:

> Date: Thu, 6 Nov 2025 10:09:42 +0100
> From: Michal Hocko <mhocko@suse.com>
> To: Robert Dinse <nanook@eskimo.com>
> Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
> Subject: Re: Folio Related Stability Crashes in 6.17.5 and 6.17.6
> 
> On Thu 06-11-25 00:24:36, Robert Dinse wrote:
>>
>>      I am installing 6.17.7 presently, I was a little resident to install
>> the current tree on a critical machine.  If need be I will.  Also, I do have
>> a crash dump on the last failure if that would be of any help.
>
> Understood, I am not sure who is going to be willing to debug this on
> top of stable tree if it is not clear whether this is a problem in
> vanila tree as well.
>
> -- 
> Michal Hocko
> SUSE Labs
>

