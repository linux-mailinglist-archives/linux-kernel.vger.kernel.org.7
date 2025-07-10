Return-Path: <linux-kernel+bounces-726609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 694CAB00F37
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 01:04:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 733011C4331A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 23:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1037329E0E4;
	Thu, 10 Jul 2025 23:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Uf6AxtQ7"
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D5328B7E9
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 23:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752188638; cv=none; b=UehCO7H2CZbiTAE1sULPYLVsJ/Yw5ZJQ2pzYOXnf5s073Zc7yLOMebwXethbFbKQQRtlteuWdW3O039NIxZ66U1/XBJpkZMGNGnDtp7lrEua8EdOZn7qKguxlvGdxUZ0PWHYmx7JSBGpduasYocxxX+c7SbdfSwIAF95myiyzpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752188638; c=relaxed/simple;
	bh=2ozQxcXrSsB6hxlvVxa5vn8vLPtgAClSg2bXK/ua/FM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=L3GVNxG7nZ0G0aOhyqGDRFRN/++suxmiajdDnXRAjL+KABpTHdcR24FUvTTB+glkLNKDCdjeeqPTSwvHRE17apKRrHkpftNEYsXD0LaTZAjPj3b6rgtV5zMfilrQJR0wIv+sKc8k6NK5aX7tP5TPm5Qqm/setT6W3aLjUaia2WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Uf6AxtQ7; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-879502274cfso54875639f.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 16:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1752188633; x=1752793433; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NgvPqkcFQWrOIbdO1eoUJrM69HgzvQkAAI7Iu+y3QxU=;
        b=Uf6AxtQ7T7MTM6htdFtrAca5oFfLn9fobRXX7RYsBq7lH1hSCp7vAs0zwA4nmUF03X
         370pLORXZzj9GkcgaWAXNk9oO8VoloP5JQjnUURpVFWy8m0eKQybuoZKLNHyQlp96zZU
         JutNMyaepi8oOGf6IufqH3LvckkIOX0e+rhxycxpt78bdGgV/jrBSyEa3Jf+7n7MRJ5J
         qJ1CdyN4vvum/3Xz388hb/RIVoge1SMNDgbboX/g7w63VePeA/vpkMxumfJPJeOoumRv
         YpFFpQ5NwRYNYJ5h0y4/z+56oBtlfHhfxmEbwgEhBtMLn430is39Tan6y8c1sQbM9NLh
         VHjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752188633; x=1752793433;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NgvPqkcFQWrOIbdO1eoUJrM69HgzvQkAAI7Iu+y3QxU=;
        b=vzfDYqE64P9ldU77bM+e4+QxB9cr6YkilTWjkG/hFzgnOsOsJurJb6QvcEWbSCaRBx
         kmkRjh0VdU5BCyekJyD67HXDI7tbwpp/F/hzxgNOT5IWvmdxSkYLh9bysbLGDuS4S2N1
         Ypx4Es11sy3JS7zNv1BJMjcRLtlENmeFyHqmguh+rSGDirGkxEqGkDS4jw+cn/mKsp/0
         X42k7nreNWxBptr8I4m4CjNHzjUtGlq8UrOoU3OMkXWq8XWktpt4FcBX0Y/oE3vH/wY2
         fabJ01WWgFE/DYoAEJztxqUS4TZtrbIGwNqVPbIqC9uSuc/VgM5q6HFWEwC/Ey+9D+sJ
         L6WA==
X-Forwarded-Encrypted: i=1; AJvYcCV+7dzXZhU6H2Mv5fJj5hprT77IXgLesmCvnWOPDEXdE68mZT3sPk5+G8+/Ex3snNWuwt8O8vH08aWgs/A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4zRo2wELP5WX7DapFlsO9i1xo53gZLkxHCWcuUDl8PKax15Xk
	ML+aRXt9IylYbHpZlbyroSaQN8WiKMjowb6oJBUavDhNlMIlVAgIi0ocs0ReH89PmwI=
X-Gm-Gg: ASbGncvYoJmNVJU4k72MJ+4BFtrBRH6Yyepwtndfn3UZ+Nt/dw7KqC5fP/YRJ5u4DfW
	t6AXP+SPBvJ3zcTbBMiBkhkz4B5vhOiqJvUFxy++ZyA0UIzYqeeQpZRI493aaowEktUUht6SZWM
	54WjltNzjvPfUQMVjYA62d6nceHzQ0QinkPP8iqTVuUn+O9QNoxd4W8w1343VZVswNO1k8ChCVR
	FvRW0FPTsMcTHI/17HhUrrihG5TLdBYnotLr3GljEObOGON0Y6guydAwt3zXVkw8KbIViDGp4z5
	diS2opNaNzPoA0pAmheUy/uSiJ/AyUdJN9Svf7/3Y5Zjyafo/OU6pbDcakIe0WMoUHUnVqfN/jd
	M9BdZlpwG6TvMPksekg==
X-Google-Smtp-Source: AGHT+IFZqw44B0Vv6nW/9xk7N7AD2QRT2sevfcK//8EjnadmBtjNxPnTSOaCyE2oZgHFeOuiaMaoDQ==
X-Received: by 2002:a05:6602:7181:b0:876:8cb1:a010 with SMTP id ca18e2360f4ac-87977f6b28cmr167309939f.7.1752188633464;
        Thu, 10 Jul 2025 16:03:53 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-8796bc13542sm61861439f.30.2025.07.10.16.03.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jul 2025 16:03:52 -0700 (PDT)
Message-ID: <b3b56a18-fdaf-4d62-946b-89dfba89f044@kernel.dk>
Date: Thu, 10 Jul 2025 17:03:51 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [io-uring?] INFO: task hung in vfs_coredump
To: syzbot <syzbot+c29db0c6705a06cb65f2@syzkaller.appspotmail.com>,
 anna-maria@linutronix.de, frederic@kernel.org, io-uring@vger.kernel.org,
 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
 tglx@linutronix.de
References: <687040ca.a00a0220.26a83e.0026.GAE@google.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <687040ca.a00a0220.26a83e.0026.GAE@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/10/25 4:38 PM, syzbot wrote:
> Hello,
> 
> syzbot has tested the proposed patch and the reproducer did not trigger any issue:
> 
> Reported-by: syzbot+c29db0c6705a06cb65f2@syzkaller.appspotmail.com
> Tested-by: syzbot+c29db0c6705a06cb65f2@syzkaller.appspotmail.com
> 
> Tested on:
> 
> commit:         5f9df768 Merge branch 'mm-everything' of git://git.ker..
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git --
> console output: https://syzkaller.appspot.com/x/log.txt?x=137fc0f0580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=44a6ca1881a12208
> dashboard link: https://syzkaller.appspot.com/bug?extid=c29db0c6705a06cb65f2
> compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
> 
> Note: no patches were applied.
> Note: testing is done by a robot and is best-effort only.

Pretty sure this was a fluke in linux-next, as it triggered around
that coredump rework, but then stopped triggering.

#syz invalid

-- 
Jens Axboe


