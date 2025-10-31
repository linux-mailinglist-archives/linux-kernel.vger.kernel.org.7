Return-Path: <linux-kernel+bounces-880512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F4DC25F3C
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 17:00:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57BDE1B21D09
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 15:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F10B2EDD6B;
	Fri, 31 Oct 2025 15:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FygITviR"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0455B2EBBA9
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 15:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761926170; cv=none; b=Hrn+cyxGsSzF3Cs3ClTgzZIT+8upr8rkBRJp8yJ77SpUtRKBHmU4x526BHquHhtql5qHRI9W8ciKKv7S9hHFZHlO+JPPE/QV9c4nEWQHfbD8OqauYGOFCOhk9LSXQbJ9wqr75zrYRXAYjU9D57P9AoRAnLLak7nLGhAr4c+4Q70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761926170; c=relaxed/simple;
	bh=z5xO/m0rwDTo6NQigKOGrGGFnxACU0bxzZRjptLe6+4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eE6NYU+Ov3Nlc5dokx2ajLKjRHxAt44Y9RAJE7fyOcLN4VHw3Y0lE1pl3ohDP0NaF7psNIPqlhAs6F/21JWZdDu2+AqifUM3BTQ1tn9n1Is5/aso4XOjz/hUEtaS9qJlZi6HCAQFGShigy747g1dP+P4Lt+r4isb530//gyajig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FygITviR; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-295291fdde4so1313185ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 08:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761926168; x=1762530968; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o/TEbnCurHUc/3b7e5l2i0tBuf8bGlvt/g1WNhbQ+jQ=;
        b=FygITviRWtTYXvpapv6V14AZIOOpjUOsSTTD0kjx9GCiJQdtx2/5VZYVk2z4tZoFG9
         Hsy8/lKKPsonP/gLO8JS/E9rgtGgrbQUQzmHznUi3bg63FrXmAy6jm39SCsCDEHJv6tV
         lU4LW3iUIQSSI0ESgxwQooY3dZKSSwIQQC/eQ3YroUxBbbzXR2rcIxWzJOdczdagF/BW
         3fZlfOEx7/zZpm9CmtseKVRoP5djW2/3Jjw0vzAn82794b4mXCXOZ3pR7r/9/NcLV2ZA
         XhuQRDATlPsZ3G0vBbqlGSvsIaOW8Qi2OgzvaPe/UY7MPuhm9adlwDNcRoAkjtQ8lIMI
         Cxig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761926168; x=1762530968;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o/TEbnCurHUc/3b7e5l2i0tBuf8bGlvt/g1WNhbQ+jQ=;
        b=XZhKt4wSwkNo5dEce/o1XyhrDn9MANBXE2aeefBzQJupy0Ht9TNZVFlWnj+p8nBl9Y
         U6/1hcq4o2m+WI/G4Ywecydv1Jl07zp4rgykC+6qDhTsdAwelIGXyj+WMmx2+8T8tMkL
         7YDARLfdDpjT6c1U6mUx9Ehj61ZuazQDFZCOVaOcaisjMBKOcM6jFEstnuh/3j2gQq3B
         cugJzyLRkAaEJkbrViZ8HCblGmUG2med1bjNh3ECh5vkp+2sz0xCPa9v8R8GylB8+ji7
         Wr5s9pHYf0EL5Yf2PiHMjGcCEp0W9vIv8OyhIMQ1oU5RSJuGxvaO39sMXUk7FbBUvtEz
         ELnw==
X-Forwarded-Encrypted: i=1; AJvYcCX9rASIgqhG5cxt7N89lePaev0SuG05+s+TqQpzgnrjTk7+FCH9wnmmzXGQ3n5mUSPHOfqxgShbKmZvQ4A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzTFFfhcyKWS/2T0BcRT2uoIDaTV0o12E3wRrBeGwSkDaEpY2f
	JYb8Oe1cdGtpp5QDm0I8cJ2ILZu45+oeHbzOjF7VtPY2cumUIGHa6YKK
X-Gm-Gg: ASbGncud++oV94e68hZt4qkucnLies7U/tOm0eV55ByRoBILciRzzdxwp+f5YZ6ndY/
	p/Ib0pYZg5QWPewDRD3ROD7TNT8LwBO0cwweDdrZzoNuq49UfnlBhwBQcS3WdWYo6mAwzl/N0FN
	eucnb2ffT8srfKR4hWm2iruwjQmatH9TygmiNBBV1Xa9gTMpcw4yqWluazh3ckLWwPFEVlTZame
	gagCF5RANpwI1S+9pZGCK5FWXsfVfkvDaRBm/rItZj/CE49gPrYGur5deii3yIT7YhbqD0oco7W
	liyWZKM+lE9VJWX+NbDgce/r+VehNyaw8F9w7xnibN4oRx7SELwlmwKra0ajK7Hp/OKdV5G70jA
	sC+YM/Hb+Ey1B7Yb9QtT4zSD07D+2PvaZy8S/WwVOTyBGoEEw5yPAitYTtJXRfIE8ueNsp6C/Nt
	G1SY7+QgQ6bB9+Uz3WFX+UY0h2e+qIRIIYsoKnfQo6f7qlH5FX0VcB
X-Google-Smtp-Source: AGHT+IGMvOOUVVK2H3mZ+2QgikwPdprzOKFpvLw8gb/AJwO95Vom6hBHxKSXXhgqcHK2Bk5A3VmauQ==
X-Received: by 2002:a17:902:f395:b0:26c:3c15:f780 with SMTP id d9443c01a7336-2951a49dd38mr19515115ad.8.1761926167936;
        Fri, 31 Oct 2025 08:56:07 -0700 (PDT)
Received: from ranganath.. ([2406:7400:10c:5702:8dcc:c993:b9bb:4994])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29526871b31sm28664475ad.8.2025.10.31.08.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 08:56:07 -0700 (PDT)
From: Ranganath V N <vnranganath.20@gmail.com>
To: edumazet@google.com
Cc: davem@davemloft.net,
	david.hunter.linux@gmail.com,
	horms@kernel.org,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	khalid@kernel.org,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	skhan@linuxfoundation.org,
	syzbot+0c85cae3350b7d486aee@syzkaller.appspotmail.com,
	vnranganath.20@gmail.com,
	xiyou.wangcong@gmail.com
Subject: Re: [PATCH] net: sched: act_ife: initialize struct tc_ife to fix KMSAN kernel-infoleak
Date: Fri, 31 Oct 2025 21:25:58 +0530
Message-ID: <20251031155558.449699-1-vnranganath.20@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CANn89iJL3upMfHB+DsuS8Ux06fM36dbHeaU5xof5-T+Fe80tFg@mail.gmail.com>
References: <CANn89iJL3upMfHB+DsuS8Ux06fM36dbHeaU5xof5-T+Fe80tFg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

>> Fix a KMSAN kernel-infoleak detected  by the syzbot .
>>
>> [net?] KMSAN: kernel-infoleak in __skb_datagram_iter
>>
>> In tcf_ife_dump(), the variable 'opt' was partially initialized using a
>> designatied initializer. While the padding bytes are reamined
>> uninitialized. nla_put() copies the entire structure into a
>> netlink message, these uninitialized bytes leaked to userspace.
>>
>> Initialize the structure with memset before assigning its fields
>> to ensure all members and padding are cleared prior to beign copied.
>>
>> This change silences the KMSAN report and prevents potential information
>> leaks from the kernel memory.
>>
>> This fix has been tested and validated by syzbot. This patch closes the
>> bug reported at the following syzkaller link and ensures no infoleak.
>>
>> Reported-by: syzbot+0c85cae3350b7d486aee@syzkaller.appspotmail.com
>> Closes: https://syzkaller.appspot.com/bug?extid=0c85cae3350b7d486aee
>> Tested-by: syzbot+0c85cae3350b7d486aee@syzkaller.appspotmail.com
>> Fixes: ef6980b6becb ("introduce IFE action")
>> Signed-off-by: Ranganath V N <vnranganath.20@gmail.com>
>> ---
>> Fix a KMSAN kernel-infoleak detected  by the syzbot .
>>
>> [net?] KMSAN: kernel-infoleak in __skb_datagram_iter
>>
>> In tcf_ife_dump(), the variable 'opt' was partially initialized using a
>> designatied initializer. While the padding bytes are reamined
>> uninitialized. nla_put() copies the entire structure into a
>> netlink message, these uninitialized bytes leaked to userspace.
>>
>> Initialize the structure with memset before assigning its fields
>> to ensure all members and padding are cleared prior to beign copied.
>> ---
>>  net/sched/act_ife.c | 13 ++++++++-----
>>  1 file changed, 8 insertions(+), 5 deletions(-)
>>
>> diff --git a/net/sched/act_ife.c b/net/sched/act_ife.c
>> index 107c6d83dc5c..608ef6cc2224 100644
>> --- a/net/sched/act_ife.c
>> +++ b/net/sched/act_ife.c
>> @@ -644,13 +644,16 @@ static int tcf_ife_dump(struct sk_buff *skb, struct tc_action *a, int bind,
>>         unsigned char *b = skb_tail_pointer(skb);
>>         struct tcf_ife_info *ife = to_ife(a);
>>         struct tcf_ife_params *p;
>> -       struct tc_ife opt = {
>> -               .index = ife->tcf_index,
>> -               .refcnt = refcount_read(&ife->tcf_refcnt) - ref,
>> -               .bindcnt = atomic_read(&ife->tcf_bindcnt) - bind,
>> -       };
>> +       struct tc_ife opt;
>>         struct tcf_t t;
>>
>> +       memset(&opt, 0, sizeof(opt));
>> +       memset(&t, 0, sizeof(t));
>
>Why is the second memset() needed ? Please do not add unrelated changes.
>
>Also I would also fix tcf_connmark_dump()

Hi Eric,
Do you want me fix tcf_connmark_dump() in this patch or new?

Regards,
Ranganath

