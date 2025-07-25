Return-Path: <linux-kernel+bounces-746082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 57674B122EE
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 19:23:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D588F7BFF80
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 17:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04E5C2EF675;
	Fri, 25 Jul 2025 17:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="UBeQvjGL"
Received: from imap4.hz.codethink.co.uk (imap4.hz.codethink.co.uk [188.40.203.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62FEB15A87C
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 17:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.203.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753464162; cv=none; b=o1//UGSdkoGqoDZwztSp+l1Z1IQ/8NkwB8hT/Py3CMCIodETHOrJcs28O+I8UR9gVaLqa1wdYUdt7NDa0cP8o/id66332tEEAIGd/WCA8KPy+/jjVBkdPUI6oU8TG/xLLOdD95KhkKjOrHGGe/t2D4U6IR9LiOM8hSqd1GPlRZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753464162; c=relaxed/simple;
	bh=8ItQbyhf7NafDWJdAJXNcjoXpLICSLa/FAyONgaFzew=;
	h=Date:Message-ID:From:Subject:To:Cc:In-Reply-To:References; b=gzDkayUmSFDd/BG/yJJoYaRW1f/x34VMT46M8EllXkp6vzGNAI7VAp21StA607eLqrrfW4O5HxbLyttSYn5Z7K02+K4Z1XtxEDv80Qy925XH22qJQZk61JmfmOLiY5L9lMECUz9kzBRibbq4BQW35xMGV/tNsp6RD++nJyRdbwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk; spf=pass smtp.mailfrom=codethink.co.uk; dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b=UBeQvjGL; arc=none smtp.client-ip=188.40.203.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codethink.co.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codethink.co.uk; s=imap4-20230908; h=Sender:References:In-Reply-To:Cc:To:
	Subject:From:Message-ID:Date:Reply-To:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=4KtHAaTsJ6vRzIFG4bK8UzOFN7UEnidqzX4TKGLUlmg=; b=UBeQvjGLZt1IX0koXmbePMWnEi
	1QaQSFS6+HD0IzROa0aOW/N1ExZddK1iBtHfbfkeXeZKL3FASJdxf07ur5fe7cpRyKw2C2GhA5UmA
	ji92+rA6D7c0OynbkfDFKp4Z+Q3GWHLdeAjzm3a29ZSwGZLRWuXjR09bXtdvBtig94GOhgz6YpBWw
	HtpoONEcgwxiNethFu89DSwsCGDtts4rFpiboNL+Yr3XbgE6YdxLnUYlI82OnVNwAakx573gp/hL2
	w/dxkIj5BHNxQunIA5MCifW/w8yPM33pvkeQdr0C1A2VEe8aWs0aGvvsElNN/vYwJC3AyHhkgtpJ3
	dhlkbpQQ==;
Received: from [109.54.187.100] (helo=localhost)
	by imap4.hz.codethink.co.uk with utf8esmtpsa  (Exim 4.94.2 #2 (Debian))
	id 1ufM7r-002KOk-Dy; Fri, 25 Jul 2025 18:22:31 +0100
Date: Fri, 25 Jul 2025 19:22:30 +0200
Message-ID: <0edd4faab01a9845fd4c847d2e5c465a@codethink.co.uk>
From: Matteo Martelli <matteo.martelli@codethink.co.uk>
Subject: Re: [PATCH] sched/deadline: Remove fair-servers from real-time task's
 bandwidth accounting
To: Yuri Andriaccio <yurand2000@gmail.com>
Cc: bsegall@google.com, dietmar.eggemann@arm.com, juri.lelli@redhat.com,
	linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it, mgorman@suse.de,
	mingo@redhat.com, peterz@infradead.org, rostedt@goodmis.org,
	vincent.guittot@linaro.org, vschneid@redhat.com,
	yuri.andriaccio@santannapisa.it
In-Reply-To: <20250725152804.14224-1-yurand2000@gmail.com>
References: <86013fcc38e582ab89b9b7e4864cc1bd@codethink.co.uk>
	<20250725152804.14224-1-yurand2000@gmail.com>
Sender: matteo.martelli@codethink.co.uk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Hi Yuri,

On Fri, 25 Jul 2025 17:28:04 +0200, Yuri Andriaccio <yurand2000@gmail.com> wrote:
> Hi,
> 
> Thank you very much for your testing, I'm very glad to know that the patch works
> as intended.
> 
> At first glance, I think the warnings you are having are related to this bug
> report that I posted a few days ago:
> https://lore.kernel.org/all/20250718113848.193139-1-yurand2000@gmail.com/
> 
> Juri Lelli checked it out and made a patch that addresses these warns here:
> https://lore.kernel.org/all/20250721-upstream-fix-dlserver-lessaggressive-b4-v1-1-4ebc10c87e40@redhat.com/
> 
> Have you already applied Juri's patch together with mine? If not, I think it
> should solve those issues you mentioned.

No, I dind't apply Juri's patch before the previously mentioned tests.
I've now applied it on top of yours and I've just rerun the same tests.
I confirm that stress-ng and runtime variations commands provide the
same results, but that the warnings are not produced anymore.

> 
> Have a nice day,
> Yuri
> 

Best regards,
Matteo


