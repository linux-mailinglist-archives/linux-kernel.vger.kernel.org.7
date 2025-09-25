Return-Path: <linux-kernel+bounces-832191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40C01B9E9A4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 12:19:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9871F3AFBA3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 10:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 538432EA723;
	Thu, 25 Sep 2025 10:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="USxf87E4"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF452E9EA6
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 10:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758795535; cv=none; b=K3Y6z6b/U3uUlpzXct+JNhZhAj9p1ynpHEBXitFbcUsJUmtZIwSGjiH1LTd2tDUZkiCsrmBQ8595HKObO8fn5GJXlPapU58UT1nSceEooDvYh+71aufH1/ihEJ6cFxLWOlQsByIes+tG7iGRAUkQ8q3FNk6ttXEZtDteN7yEwUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758795535; c=relaxed/simple;
	bh=0szZ/1t2vF723fTx+0uYOJw7RgMxwYGlCm1Nqaxh6Dg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=McNlmjpa7H2Jqwn6NJB9NzsJFreAhF4JdyDba8nnCs3cum+XgFT8lG8n36IQ5RRD+4DB73bXmyhUJ82u4xLTgdt5Hlxh2rROdM/fFyGjBIj2m9IishFIcZ1W+bEGXI/icQe33IRCOpeaW32gfQOZBrMsEOxvmALy51MhTVtl6TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=USxf87E4; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-63486ff378cso2371155a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 03:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1758795532; x=1759400332; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=opLUmUG+lsRAbSy1R5a7UUs1ZFkf867TQlaVzzmhmQI=;
        b=USxf87E4a3wTPwlQzSRSmfEXT1sLetG19ySjUwclrh0qTKXbdaU9jd8qe66cTEFrtP
         O9UGT5VYl6Y23dmY+p/PBSsXThAwFZa0DX7KGCGYPpQSP2NKshcaPNCOorZvY/pid57D
         uciVqr55gTbLgzDUUKU6g+kAUfjPki2ii59/JLcvloX/SAqVezNrg5ifnb+6KhgdB8go
         Da3sb6Xvimh2VUYGRIqDI9kKs4GjtQdWaSohKjpfkeq1Aj6lOlE3wqlAGYojXHJ8IBvT
         6aLFlQ2h61v7IvSoLXpAp1U/yxd76FHgEs0tn5Id8GOjhDn2kCiGlk8wVVARiKtB3hjH
         /x4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758795532; x=1759400332;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=opLUmUG+lsRAbSy1R5a7UUs1ZFkf867TQlaVzzmhmQI=;
        b=B0/KUagxoJ0XIFugab1oD17gztl45G1sqwRcpWtfLhHJD2JhTjupE9f8hRwgKTDIBM
         7azdEprrICyqVpY/jaRRu/gpuyNvrU1QqP6Hett5XcyKTU25A1lZjLq7/Q9mLZbDIpxV
         unIgX2a3s8+VhRa1WxNe8zyXk3KbYeol006Dub+s5uPms3JVcDSjVIYU3BNiXd+2Y/g1
         F2whbC/hH3QbYKXhOV2pad2OzWBV3KjIWtH7Gxs2zgAMWo0VklvrEjUQ9GBn2Gy49+R3
         NH0mjhL/vXWXWE52CAHewPr4qMcdSvSkthBoI3WB/ABPFOrYKrg+TVVkrZLIWQr98XGa
         EiVg==
X-Forwarded-Encrypted: i=1; AJvYcCWtbNSpGpUI20t4X/wZ491G47nDwhM7zfuiQzQSlr5bn5faOinzJUHMBoQCI9Grs0hn1n+Wqtcvkytzfmw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpjwFWhlxCnDzRBX3mUG1sQt1rLD0zrdQhOoWUfBWj7kSVQLWY
	5MBBIkJSA9BlRa2Wh6lLAZmxBnVgfxp7XzwoGzVV3SIMbbkyz0yL3TNSlP0WtMA7n0c=
X-Gm-Gg: ASbGnctqHkYg4No1zeIYIi+8qHpXDqjAXgPkAn+lkZkGwciPAkIgGp8XyKpMREz3ls7
	y13Dtq4BRG/9xe0Fa9dgWlsTbp2CBkwdHAH/EZII4GYW01E3L2nD1a+OI0Hfl+8H53vjgMlmp+B
	n4Se59NHCY7B0NKL7hqXKaQ5OdugbaRW3tcT4TAGGcwXGg1Ccgg+dX3jEiTIe6IN0o5tOm32xz2
	hve716ke/qRljD5cK2w5fc6xaV2bfT0jbq8u7c3SFx2Njb2sajx3myS7hNqC2X4V1CcMoO6UWpe
	kNC9islGTsWiuiT80ezF9LlVeGMyyocuX95EIskIDAMfo6Svak8jflhf8qfcBDsYxXwaEVzlyAr
	wmpssv4uEO9MC5eXys77t6Ras5g==
X-Google-Smtp-Source: AGHT+IFhft95WME5prTDF0IZI8kkYS3aAO32jFFFBf65s/9jPTkMU0F9cjZ8kCcS0fWYH8vfDPruLQ==
X-Received: by 2002:a17:906:6a02:b0:b35:cc60:9fd1 with SMTP id a640c23a62f3a-b35cc7000a9mr165718466b.18.1758795532196;
        Thu, 25 Sep 2025 03:18:52 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac6:d677:295f::41f:5e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b35446f758csm139119666b.53.2025.09.25.03.18.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 03:18:51 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
Cc: davem@davemloft.net,  edumazet@google.com,  kuba@kernel.org,
  pabeni@redhat.com,  donald.hunter@gmail.com,  andrew+netdev@lunn.ch,
  ast@kernel.org,  daniel@iogearbox.net,  hawk@kernel.org,
  john.fastabend@gmail.com,  matttbe@kernel.org,  chuck.lever@oracle.com,
  jdamato@fastly.com,  skhawaja@google.com,  dw@davidwei.uk,
  mkarsten@uwaterloo.ca,  yoong.siang.song@intel.com,
  david.hunter.linux@gmail.com,  skhan@linuxfoundation.org,
  horms@kernel.org,  sdf@fomichev.me,  netdev@vger.kernel.org,
  linux-kernel@vger.kernel.org,  bpf@vger.kernel.org,
  linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH RFC 0/4] Add XDP RX queue index metadata via kfuncs
In-Reply-To: <0cddb596-a70b-48d4-9d8e-c6cb76abd9d2@gmail.com> (Mehdi Ben Hadj
	Khelifa's message of "Thu, 25 Sep 2025 11:54:59 +0100")
References: <20250923210026.3870-1-mehdi.benhadjkhelifa@gmail.com>
	<87h5wq50l0.fsf@cloudflare.com>
	<0cddb596-a70b-48d4-9d8e-c6cb76abd9d2@gmail.com>
Date: Thu, 25 Sep 2025 12:18:50 +0200
Message-ID: <87348a4yyd.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Sep 25, 2025 at 11:54 AM +01, Mehdi Ben Hadj Khelifa wrote:
> On 9/25/25 10:43 AM, Jakub Sitnicki wrote:
>> On Tue, Sep 23, 2025 at 10:00 PM +01, Mehdi Ben Hadj Khelifa wrote:
>>>   This patch series is intended to make a base for setting
>>>   queue_index in the xdp_rxq_info struct in bpf/cpumap.c to
>>>   the right index. Although that part I still didn't figure
>>>   out yet,I m searching for my guidance to do that as well
>>>   as for the correctness of the patches in this series.
>> What is the use case/movtivation behind this work?
>
> The goal of the work is to have xdp programs have the correct packet RX queue
> index after being redirected through cpumap because currently the queue_index
> gets unset or more accurately set to 0 as a default in xdp_rxq_info. This is my
> current understanding.I still have to know how I can propogate that HW hint from
> the NICs to the function where I need it.

This explains what this series does, the desired end state of
information passing, but not why is does it - how that information is
going to be consumed? To what end?

I'd start by figuring that part out. Otherwise you're just proposing
adding code that serves no actual purpose.

