Return-Path: <linux-kernel+bounces-868595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7089CC0594B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 12:30:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA1863B2D99
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 10:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ECCE30F939;
	Fri, 24 Oct 2025 10:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="gBUI0Om3"
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5979E30F812
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 10:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761301522; cv=none; b=LuIPLiLb70N1tJdhj85aMAMLHRY+mgzjYihuLxdMVAOz9eGJ91bnjY2qRLQ2ZAWkQgNXF3/i5n5XOv90NjUOXGaVuL9d7n8yHSfB26+Wy+nCUk2f1c6BFS4j2roPPb+o38M5uikrwxOTCJDuoCSFya1KN5tb7qWHfDG8jEnLi80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761301522; c=relaxed/simple;
	bh=jvTr0+pzSdvfc+fnO5V6si3PUqeSsDTXUlWdUdJ/UQc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Xe8fJEiH9PX8UG0qLhnaZD/l/xpfJ781TUdWPwGId6zuiuuAu9q4TNm4bo1bS5LAlBW5USIP+ZBmFQAVgWD40pa2uwJZDTvIIkGfnoH9fxMoQRtbeBLGNopubqvbYh0haEVrRki3Rj66z9DzXLmjwhbdhk5mMIYkx6nIqKcky68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=gBUI0Om3; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Received: from relayfre-01.paragon-software.com (unknown [176.12.100.13])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 2793F1DDC;
	Fri, 24 Oct 2025 10:22:12 +0000 (UTC)
Authentication-Results: relayaws-01.paragon-software.com;
	dkim=pass (1024-bit key; unprotected) header.d=paragon-software.com header.i=@paragon-software.com header.b=gBUI0Om3;
	dkim-atps=neutral
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayfre-01.paragon-software.com (Postfix) with ESMTPS id D2B66247B;
	Fri, 24 Oct 2025 10:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1761301513;
	bh=PJTfucEXJR/z1+oDGBEhv38RbCI66UvZFo/3sc/r08Q=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=gBUI0Om3g16B/iRTjF54wdKZuPkaOrZtFEcrQS0QLNkqD93EJkfMfiaUvqKWqriLW
	 Zg9XicWJnDxzZ/MUQ9JndIX9MMkJJYFlyQZ/nNqQ9HonxkIJThkRC1qEjCxMiagnQQ
	 8SrcaUSwMidlc3RrriyJR/HIqdVFcvnB8ipkDpyY=
Received: from [192.168.95.128] (172.30.20.195) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 24 Oct 2025 13:25:10 +0300
Message-ID: <ca863643-e283-4a65-924d-2a5cacac134a@paragon-software.com>
Date: Fri, 24 Oct 2025 12:25:09 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Bug] Memory allocation errors and system crashing due to buggy
 disk cache/inode allocations by ntfs3 kernel module.
To: <OaiyHa1----9@tutamail.com>, <craftfever@tutamail.com>
CC: <linux-kernel@vger.kernel.org>, <ntfs3@lists.linux.dev>,
	<regressions@lists.linux.dev>, <regressions@leemhuis.info>
References: <081a1c85c9891bd41fbbb2e0cbb702e696799d40@murena.io>
Content-Language: en-US
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
In-Reply-To: <081a1c85c9891bd41fbbb2e0cbb702e696799d40@murena.io>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)

On 10/6/25 12:30, craftfever@murena.io wrote:

> (i'd to change e-mail for setting correspoing headers for reply)
> I made interesting investigation about the problem and found that if I put in kernel parameters preempt=full and threadirqs, crashing is gone, but corresponding process (git in this case) hangs and starting  consuming CPU (therefore writing files is not happens) and it's impossible to kill it. But system is not crashing and stable in this case, case with full kernel preemption.

Hello,

Sorry for the delayed reply, and thanks for reporting this.
I'll try to reproduce the bug and follow up with my findings.

Regards,
Konstantin


