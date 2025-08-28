Return-Path: <linux-kernel+bounces-789812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 30A62B39B01
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 13:06:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66B341884A06
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 11:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3227530C624;
	Thu, 28 Aug 2025 11:06:41 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B742459E1
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 11:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756379200; cv=none; b=Di4ECfnJnr6KN0gzcLlUFWfGNzFlUjrzaucofmxDGspwUSv8rPzpIMT25QUKQqgxL61HdvY+biM7Fsw2pi+ZTiLFPeK9XAiBA8COOf+FHFv2mz4k//2eznp12Xjm0BvI/fKE4N/tVwHf9Fc684O7Yti1Qe1TDXYODqIkbsbLunw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756379200; c=relaxed/simple;
	bh=Nas3Yc0d+xnRKeHP94h5sYkVeRl3KlV0gfHSlr8sc74=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aYGRTvdGCU72VNWpStR/4DH3USVr6r3ylphsO7z+XTFHoZNUu7lT/9vAHfp+h0CAvB7tNG1IlJpvNHKe4jJjFg8CP0SLgE+z+FoiZdl+MVlfuonfmde3hpIfy7qX+vzFUmexSJxNF/7CdadLoIOaCl3JatzgQKVkQS8CY/yMxzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 57SB6TST092890;
	Thu, 28 Aug 2025 20:06:29 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 57SB6TbS092886
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 28 Aug 2025 20:06:29 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <2a58b0b4-1c67-46d2-9c2a-fce3d26fc846@I-love.SAKURA.ne.jp>
Date: Thu, 28 Aug 2025 20:06:29 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [net?] WARNING in xfrm_state_fini (3)
To: Sabrina Dubroca <sd@queasysnail.net>,
        Steffen Klassert <steffen.klassert@secunet.com>
Cc: syzbot <syzbot+6641a61fe0e2e89ae8c5@syzkaller.appspotmail.com>,
        davem@davemloft.net, edumazet@google.com, herbert@gondor.apana.org.au,
        horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com
References: <6888736f.a00a0220.b12ec.00ca.GAE@google.com>
 <aIiqAjZzjl7uNeSb@gauss3.secunet.de> <aIisBdRAM2vZ_VCW@krikkit>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <aIisBdRAM2vZ_VCW@krikkit>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav405.rs.sakura.ne.jp
X-Virus-Status: clean

syzbot is still hitting this problem. Please check.

On 2025/07/29 20:09, Sabrina Dubroca wrote:
>> Hi Sabrina, your recent ipcomp patches seem to trigger this issue.
>> At least reverting them make it go away. Can you please look
>> into this?
> 
> I haven't looked at the other reports yet, but this one seems to be a
> stupid mistake in my revert patch. With these changes, the syzbot
> repro stops splatting here:

