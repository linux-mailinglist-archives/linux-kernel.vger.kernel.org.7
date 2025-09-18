Return-Path: <linux-kernel+bounces-823626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A28D1B87078
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 23:12:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A7FD1CC1771
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 21:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 636742E0937;
	Thu, 18 Sep 2025 21:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PbvPYiH2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D333229D297
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 21:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758229901; cv=none; b=KA1HsZUXZsICP9L/8m+QVSY/NEsr3kunf2kUop509pR4+tJDNDzLWI1yiDih5u8Uy2jYPbh7JcaGSjYM7bJsFVZ6CEiMP+AXtB/1PJZnJSGKTVtNmI6Q0BBJ/t7DdXe7p0Rw9G/IZMeFZpsJZD8FvbkYad2yTkDeX6GfTCILHDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758229901; c=relaxed/simple;
	bh=d/kW/HcYN9nla+sQrwTP7d7AwmwYKGAE1oAjjBx2IvE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=q1RvWNwek4rWz/JliWNbVZTrpyyxJFqLQXDD9JPQEEVc3Z0afkJw3HhUlfX2nr4tzCMNSopaRonQ9ydAbn1eWtcjryj6R8Nh3L/z8L8L+t+/X0Apx52cMnnBQa486e1qKoVRlVxqTw+ustNM9PBoERx71YewTNuMoe526CJmH0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PbvPYiH2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758229898;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=haj5Uj8dJJVDzLSrDajsILQl1ABk/7DJdOuc9K4PXFY=;
	b=PbvPYiH2Q4Mc+g328ErgrLtAWPlbBA5H91OKzOU2/93loGl4vB4Gn1cQhrv78iaylgNnSY
	AfHwzzuzbrom76+wttAXi4nixZh0nkaXd4UDXS8zN2tgNSZkkErR9/OaZKc+VTaIyorZ8o
	TKN/g/s2rXpaqWJ5P3qFjDBgAV5HUu4=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-197-mAdwVQOGMpWidmvlfJU3ZA-1; Thu, 18 Sep 2025 17:11:37 -0400
X-MC-Unique: mAdwVQOGMpWidmvlfJU3ZA-1
X-Mimecast-MFC-AGG-ID: mAdwVQOGMpWidmvlfJU3ZA_1758229896
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-62f6b678424so1406439a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 14:11:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758229896; x=1758834696;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=haj5Uj8dJJVDzLSrDajsILQl1ABk/7DJdOuc9K4PXFY=;
        b=kaeqF00kL3NRXX+PmsQuFsb93Xg1Pp0dJhcUVUMikbDs+g6xtcqbk+K8R5LKMoaUVt
         iukHkqYfKHRv/z6C7p5VeBDpCyBO3oL9J8MOxsffr/CEpP+uoXIF6dRfH25g3/5xbq6J
         NKXI4yc5+u7yge91ZHj6txwDVm9chkLKAykIWsYo2uj8f0nTE703L+3DUFeaOOXxfZ3I
         jwQ00rrZCto3XbUuPCnONnhp9TdiPoy5xDzy2Y2mrlpAVGUpTpS8fotfzXGIUfHMgy7L
         r5hapQbRBSSUKFgX/VCll0qFWFSnU6bKhTL9HaCkRhqBdCyvTKIrCGZq57DPbeDSziQh
         Dxtg==
X-Forwarded-Encrypted: i=1; AJvYcCVNthy+PEhOrEp8SdYgdCdr4qcAJIoSjM0IWqiXSn/+TvDOF/74Xl2vx3ukURe1MiAJBEjZOXAOiEbDgVA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ9gtc+c9LLoVVSdyEsjQ53bjwTHiiomIMQK2gnmFC+lIg0+Ro
	oBIxiwreYdZA61So65xVLyU5I6CwtxRxfOku3gRM2U3pbxcVUiIY+R76ay+/R0Sz8tL3QvJoxzk
	wEFiPXVokFatjZQuhzDUxMZmqWrNi6J1KzmDTrCb9XmN8iQTNFYTKmhO1ogokUogTZ6+rlAPEzH
	eyzRfBdYGWaruOJo3NRwzRk9KIQxzxEzUw6fDp9wpG
X-Gm-Gg: ASbGncuVhJn3avyZ9pQGAP+/GIRiUheS+DdlgKC18Ill8oefIGMzSLUmAGf7ThjraXG
	L3YiXaAR99kEshR3+3We2SjuQOy2XtnBpFd+BWd1luQ5TMb85k4wzsrRXhQbJ7Bo6qU4MuMslOz
	LVRONm474aUnmtxzFFIks3k51VkXPpRrYRg94ibTgKDPdKDtvxYZ/zf68=
X-Received: by 2002:a05:6402:4590:b0:62f:26f8:fea0 with SMTP id 4fb4d7f45d1cf-62fc0ae510bmr592310a12.33.1758229895969;
        Thu, 18 Sep 2025 14:11:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGVsf0wPfY2krtuiF6FtWzTWN+KTRh5W+pGyw46TzmZ5KI7bREpTcAjgqu3sARTuQvFocsVoOPXRV7Lhci+4OI=
X-Received: by 2002:a05:6402:4590:b0:62f:26f8:fea0 with SMTP id
 4fb4d7f45d1cf-62fc0ae510bmr592286a12.33.1758229895590; Thu, 18 Sep 2025
 14:11:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Anubhav Shelat <ashelat@redhat.com>
Date: Thu, 18 Sep 2025 17:11:24 -0400
X-Gm-Features: AS18NWCQhQ6_-HrdR_kCbVx74ouvilsy7PA-2w8NPyBaEQbcP4k4yjoRnUu5clI
Message-ID: <CA+G8DhLzk-XbwoBbtvwnKZXXadWAqy0aApiOiS1-xPvkZb0sCA@mail.gmail.com>
Subject: Re: [PATCH] perf/test: Skip leader sampling for s390
To: eranian@google.com
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, agordeev@linux.ibm.com, ctshao@google.com, 
	gor@linux.ibm.com, hca@linux.ibm.com, Ian Rogers <irogers@google.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-s390@vger.kernel.org, Namhyung Kim <namhyung@kernel.org>, peterz@infradead.org, 
	sumanthk@linux.ibm.com, tmricht@linux.ibm.com, 
	Michael Petlan <mpetlan@redhat.com>
Content-Type: text/plain; charset="UTF-8"

I believe this issue is causing perf record tests to fail leader
samping on aarch64 machines. The important commands from the test:

# ./perf record -e "{cycles,cycles}:Su" -- ./perf test -w brstack
Lowering default frequency rate from 4000 to 1400.
Please consider tweaking /proc/sys/kernel/perf_event_max_sample_rate.
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.019 MB perf.data (210 samples) ]
# ./perf script -i perf.data | grep brstack
            perf   98281 184091.292956:     621736 cycles:
53b844 brstack_bench+0x40 (/root/linux/tools/perf/perf)
            perf   98281 184091.292956:     621765 cycles:
53b844 brstack_bench+0x40 (/root/linux/tools/perf/perf)
            perf   98281 184091.293346:     611236 cycles:
53b784 brstack_bar+0x24 (/root/linux/tools/perf/perf)
            perf   98281 184091.293346:     611266 cycles:
53b784 brstack_bar+0x24 (/root/linux/tools/perf/perf)
            perf   98281 184091.293734:     587649 cycles:
53b844 brstack_bench+0x40 (/root/linux/tools/perf/perf)
            perf   98281 184091.293734:     587678 cycles:
53b844 brstack_bench+0x40 (/root/linux/tools/perf/perf)
            perf   98281 184091.294155:     648439 cycles:
53b780 brstack_bar+0x20 (/root/linux/tools/perf/perf)
            perf   98281 184091.294155:     648469 cycles:
53b780 brstack_bar+0x20 (/root/linux/tools/perf/perf)
            perf   98281 184091.294588:     716679 cycles:
53b844 brstack_bench+0x40 (/root/linux/tools/perf/perf)
            perf   98281 184091.294588:     716709 cycles:
53b844 brstack_bench+0x40 (/root/linux/tools/perf/perf)
            perf   98281 184091.295050:     779147 cycles:
53b814 brstack_bench+0x10 (/root/linux/tools/perf/perf)
            perf   98281 184091.295050:     779177 cycles:
53b814 brstack_bench+0x10 (/root/linux/tools/perf/perf)
            perf   98281 184091.295545:     842413 cycles:
53b8b8 brstack_bench+0xb4 (/root/linux/tools/perf/perf)
            perf   98281 184091.295545:     842443 cycles:
53b8b8 brstack_bench+0xb4 (/root/linux/tools/perf/perf)
            perf   98281 184091.296191:     899736 cycles:
53b77c brstack_bar+0x1c (/root/linux/tools/perf/perf)
            perf   98281 184091.296191:     899766 cycles:
53b77c brstack_bar+0x1c (/root/linux/tools/perf/perf)
            perf   98281 184091.296721:     914623 cycles:
53b794 brstack_bar+0x34 (/root/linux/tools/perf/perf)
            perf   98281 184091.296721:     914652 cycles:
53b794 brstack_bar+0x34 (/root/linux/tools/perf/perf)
            perf   98281 184091.297255:     926741 cycles:
53b7a8 brstack_bar+0x48 (/root/linux/tools/perf/perf)
            perf   98281 184091.297255:     926770 cycles:
53b7a8 brstack_bar+0x48 (/root/linux/tools/perf/perf)
            perf   98281 184091.297813:     966974 cycles:
53b778 brstack_bar+0x18 (/root/linux/tools/perf/perf)
            perf   98281 184091.297813:     967003 cycles:
53b778 brstack_bar+0x18 (/root/linux/tools/perf/perf)
            perf   98281 184091.298394:    1007743 cycles:
53b784 brstack_bar+0x24 (/root/linux/tools/perf/perf)
            perf   98281 184091.298394:    1007772 cycles:
53b784 brstack_bar+0x24 (/root/linux/tools/perf/perf)
            perf   98281 184091.298991:    1043010 cycles:
53b794 brstack_bar+0x34 (/root/linux/tools/perf/perf)
            perf   98281 184091.298991:    1043039 cycles:
53b794 brstack_bar+0x34 (/root/linux/tools/perf/perf)
            perf   98281 184091.299604:    1072961 cycles:
53b794 brstack_bar+0x34 (/root/linux/tools/perf/perf)
            perf   98281 184091.299604:    1072990 cycles:
53b794 brstack_bar+0x34 (/root/linux/tools/perf/perf)
            perf   98281 184091.300234:    1099175 cycles:
53b768 brstack_bar+0x8 (/root/linux/tools/perf/perf)
            perf   98281 184091.300234:    1099204 cycles:
53b768 brstack_bar+0x8 (/root/linux/tools/perf/perf)
            perf   98281 184091.300870:    1121830 cycles:
53b898 brstack_bench+0x94 (/root/linux/tools/perf/perf)
            perf   98281 184091.300870:    1121860 cycles:
53b898 brstack_bench+0x94 (/root/linux/tools/perf/perf)
            perf   98281 184091.301515:    1140634 cycles:
53b788 brstack_bar+0x28 (/root/linux/tools/perf/perf)
            perf   98281 184091.301515:    1140664 cycles:
53b788 brstack_bar+0x28 (/root/linux/tools/perf/perf)
            perf   98281 184091.302174:    1158251 cycles:
53b7f0 brstack_foo+0x40 (/root/linux/tools/perf/perf)
            perf   98281 184091.302174:    1158281 cycles:
53b7f0 brstack_foo+0x40 (/root/linux/tools/perf/perf)
            perf   98281 184091.302838:    1173750 cycles:
53b774 brstack_bar+0x14 (/root/linux/tools/perf/perf)
            perf   98281 184091.302838:    1173780 cycles:
53b774 brstack_bar+0x14 (/root/linux/tools/perf/perf)
            perf   98281 184091.303504:    1186018 cycles:
53b794 brstack_bar+0x34 (/root/linux/tools/perf/perf)
            perf   98281 184091.303504:    1186048 cycles:
53b794 brstack_bar+0x34 (/root/linux/tools/perf/perf)
            perf   98281 184091.304185:    1197272 cycles:
53b7fc brstack_foo+0x4c (/root/linux/tools/perf/perf)
            perf   98281 184091.304185:    1197302 cycles:
53b7fc brstack_foo+0x4c (/root/linux/tools/perf/perf)
            perf   98281 184091.304864:    1208165 cycles:
53b768 brstack_bar+0x8 (/root/linux/tools/perf/perf)
            perf   98281 184091.304864:    1208194 cycles:
53b768 brstack_bar+0x8 (/root/linux/tools/perf/perf)
            perf   98281 184091.306794:    1215537 cycles:
53b914 brstack+0x58 (/root/linux/tools/perf/perf)
            perf   98281 184091.306794:    3426542 cycles:
53b914 brstack+0x58 (/root/linux/tools/perf/perf)

Usually the difference between the leader and sibling counts is about
30 cycles, but occasionally there's a really big difference. When
running the perf record with '-e "{cycles,cycles,cycles}:Su"' the two
sibling events have the same cycle count.
There is no difference between the leader and sibling when running on
x86 systems using the cycles event, but when using the task-clock
event, the results were similar to Thomas' on both x86 and aarch64.

Any advice would be appreciated.

Thanks,
Anubhav


