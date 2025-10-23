Return-Path: <linux-kernel+bounces-867484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4A80C02C30
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 19:39:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EC171AA4A57
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 17:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 627CD34B1B4;
	Thu, 23 Oct 2025 17:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HExkoKIF"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2B634B19A
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 17:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761241090; cv=none; b=T528E/YDdj29r/JjVeeMRiDZgK+x2M1tmFnI9uhtE17YyaCrCAXRc6ttqsItaPD4gYAd44/dNE5/uTIvBasroK/yFv7mz8vVQFQO0RI46aB0HiwaKcY1zswoYYrjCV1ns/Ba6CEvFXPVxOBgMAie926ZbLzMxhwSnOReSmkkgR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761241090; c=relaxed/simple;
	bh=eBDxFhTmvNljnNBxHbg/eZhmGw4aVF+uG/C4ZfN27f8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EIvtWBnfqvhgipCrOe8DWFsa6ol9zlXmOsu2S84lrOxY8zbMH8TyHm9224jQy8m5SCTpWo0Y+Yr8WkzBC1wgPveQpSsZiee/m/1qXyRVDvK/aTDaoirKvy+88bFx6zKw8htI0nHp7h4NLgj4nlAQrJCqRzYL13LSD68gHBiYZdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HExkoKIF; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7a1603a098eso756915b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 10:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761241088; x=1761845888; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eBDxFhTmvNljnNBxHbg/eZhmGw4aVF+uG/C4ZfN27f8=;
        b=HExkoKIFAMr/4fvUkO4yl7mDcvvBuLJDUFde6m8hYACveG3qAluJVpedcJE9FdQZfT
         4I9LIi/93zaVpKCGaMlvpcHWedPXbefbzTSiP7CJut3qSvyhyexPbyphJTvzAT3jlrZs
         KBPVE5wSJEL9H7YQPTcDeoU22zLd0pqCKt7MHWboI5dLt6IHWHj8fLnSrvyr05hWw8MH
         7LFJfs2j68KwTUlFG+A8BTXLNWdtSKsp3jtGuf/XsZaKxikE7JJgP9sMWtefVTHRRXlW
         gUxSEfyMGma8C/leLlTpOcGuUrE7NRDWwJknCA90H9Qmmi11GPPnm9O6egf6z9+TEJ+8
         kTVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761241088; x=1761845888;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eBDxFhTmvNljnNBxHbg/eZhmGw4aVF+uG/C4ZfN27f8=;
        b=F2Ig9RhU6bNT75b4KswNLpR3glj/6uZYjDvo1ygEsKPrwYx3N41nROcsXND0ZsD5AV
         /5mRH11ap3L01Lvn8Kg20yDVm7ry7ByS/vNY4rt/pXNTXbVVzr4rKhxpJL/LaQNVDUBo
         VYTtdicBoamzC0D1N2YOSmuarvVsgRoT5JBDENXlY9QQElJzdd6iL567sy6ZSdbgRFLZ
         Hv/KaX/ACs8i5Dof2Y1Qd5tGS+Nx1LCQejPJazG0ABVx75880pSBzJLLqr4CH5oa/ZCu
         88+A2c7HD/qF9tSeujOqq6M9Frp5J6r9HLrqcgp7rxcwoC8dONErQId0B5IAtbqJNu7v
         ypQA==
X-Forwarded-Encrypted: i=1; AJvYcCWuMOizwEzAXYZC+dwQadkIceoVnmFLfj1aFbEgW0Ob9HTDZaYLuFUjnJ9Q6o7Rib7L7AqtFUdOGbWFPV0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZQfTmiFWr3v+RJELkjqC+Dkw1rWVkOlILdSZoprhhu9mA7H81
	ppCtGclzLHJNY1a6ia1qDp64ImHZLTb8jU1RIzeI2TNVPVtyDN70/RK8
X-Gm-Gg: ASbGncsbKBoFMm5EFPuR2Jq5pOGaKfH4Xe2kI0YmbJYwhNXPNLr6WDs6Paf7tMcxtIj
	AG7Tlerb2ZoMQAKpWOL5VfTurGaO6T8q3YS2TVrHcGqiy/h/GIbigXE8OqUxbm9ZYVkX1FUH8yB
	sia9g71TJYl7GjJ+WDK9dxIkPYptwHXNUr1iGIOiIBnbAn6idKzIfxTg3Jm42o59WF09/WYGDjz
	tfXAmgU3011glDT571pVwzdJ+ZLvXzLCu/kwM4aT9Jv4r8OLIk7SmE8ppxhT0bpcszUq40IzMmU
	X2fVj03yM0IwP36SOt6onbYs8N5038HJEUszsSYQ/Sy3Tdfaw4Ur4qxnZxM1NzXLzhOjgVYhg3v
	FpIVJVE2VsIon5MHxzNTf6Ar4Q4JZePiJpuYvIIxeK0RO9z9Uv/epStGqppRrv5CkSVfBVmc9hF
	yxlPD3tUOb
X-Google-Smtp-Source: AGHT+IFC0YwfZSSr11JmBgZxVdA4VUbjMUbFx8xFl+44Img0emziFg2b28iBe4lH7T9MEURl06getA==
X-Received: by 2002:a05:6a20:158a:b0:2d9:c2:5ce4 with SMTP id adf61e73a8af0-334a8524456mr33550906637.7.1761241088092;
        Thu, 23 Oct 2025 10:38:08 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a274ac3158sm3128772b3a.32.2025.10.23.10.38.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 10:38:07 -0700 (PDT)
Message-ID: <f0a52150bc99aa4da1a25d6181975cd3c80a717f.camel@gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Skip bounds adjustment for
 conditional jumps on same register
From: Eduard Zingerman <eddyz87@gmail.com>
To: KaFai Wan <kafai.wan@linux.dev>, Alexei Starovoitov
	 <alexei.starovoitov@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, John Fastabend
 <john.fastabend@gmail.com>, Andrii Nakryiko	 <andrii@kernel.org>, Martin
 KaFai Lau <martin.lau@linux.dev>, Song Liu	 <song@kernel.org>, KP Singh
 <kpsingh@kernel.org>, Stanislav Fomichev	 <sdf@fomichev.me>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,  Shuah Khan
 <shuah@kernel.org>, Paul Chaignon <paul.chaignon@gmail.com>, Matan Shachnai
	 <m.shachnai@gmail.com>, Luis Gerhorst <luis.gerhorst@fau.de>, 
	colin.i.king@gmail.com, Harishankar Vishwanathan	
 <harishankar.vishwanathan@gmail.com>, bpf <bpf@vger.kernel.org>, LKML	
 <linux-kernel@vger.kernel.org>, "open list:KERNEL SELFTEST FRAMEWORK"	
 <linux-kselftest@vger.kernel.org>, Kaiyan Mei <M202472210@hust.edu.cn>, 
 Yinhao Hu <dddddd@hust.edu.cn>
Date: Thu, 23 Oct 2025 10:38:04 -0700
In-Reply-To: <0d267da41178f3ac4669621516888a06d6aa5665.camel@linux.dev>
References: <20251022164457.1203756-1-kafai.wan@linux.dev>
		 <20251022164457.1203756-2-kafai.wan@linux.dev>
		 <39af9321-fb9b-4cee-84f1-77248a375e85@linux.dev>
		 <1d03174dfe2a7eab1166596c85a6b586a660dffc.camel@gmail.com>
		 <CAADnVQKdMcOkkqNa3LbGWqsz9iHAODFSinokj6htbGi0N66h_Q@mail.gmail.com>
		 <abe1bd5def7494653d52425818815baa54a3628a.camel@gmail.com>
	 <0d267da41178f3ac4669621516888a06d6aa5665.camel@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gVGh1LCAyMDI1LTEwLTIzIGF0IDE5OjI2ICswODAwLCBLYUZhaSBXYW4gd3JvdGU6CgpbLi4u
XQoKPiA+IEBAIC0xNjE3Myw2ICsxNjE3MywyNSBAQCBzdGF0aWMgaW50IGlzX3BrdF9wdHJfYnJh
bmNoX3Rha2VuKHN0cnVjdAo+ID4gYnBmX3JlZ19zdGF0ZSAqZHN0X3JlZywKPiA+IMKgc3RhdGlj
IGludCBpc19icmFuY2hfdGFrZW4oc3RydWN0IGJwZl9yZWdfc3RhdGUgKnJlZzEsIHN0cnVjdCBi
cGZfcmVnX3N0YXRlCj4gPiAqcmVnMiwKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdTggb3Bjb2RlLCBib29sIGlzX2ptcDMyKQo+ID4gwqB7
Cj4gPiArwqDCoMKgwqDCoMKgIGlmIChyZWcxID09IHJlZzIpIHsKPiA+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIHN3aXRjaCAob3Bjb2RlKSB7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBjYXNlIEJQRl9KR0U6Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBjYXNlIEJQRl9KTEU6Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjYXNlIEJQ
Rl9KU0dFOgo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY2FzZSBCUEZfSlNMRToK
PiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNhc2UgQlBGX0pFUToKPiA+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNhc2UgQlBGX0pTRVQ6Cj4gCj4gT3RoZXJzIGFyZSBm
aW5lLCBidXQgQlBGX0pTRVQgb24gdGhlIHNhbWUgcmVnaXN0ZXIgY291bGQgYmUgMCAoaWYgdmFs
dWUgaXMgMCkuCj4gQW5kIGl0J3MgdW5rbm93biB0byB0YWtlIHRoZSBicmFuY2ggaWYgMCB3aXRo
aW4gdGhlIHJhbmdlLgoKUmlnaHQsIG1pc3NlZCB0aGF0IG9uZS4KCj4gCj4gPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIDE7Cj4gPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjYXNlIEJQRl9KR1Q6Cj4gPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBjYXNlIEJQRl9KTFQ6Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBjYXNlIEJQRl9KU0dUOgo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY2Fz
ZSBCUEZfSlNMVDoKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNhc2UgQlBGX0pO
RToKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1
cm4gMDsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGRlZmF1bHQ6Cj4gPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIC0xOwo+ID4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfQo+ID4gK8KgwqDCoMKgwqDCoCB9Cj4gPiAK
PiA+IEJ1dCB0aGF0J3MgdG9vIG11Y2ggY29kZSBmb3IgYW4gYXJ0aWZpY2lhbCBjYXNlLgo+ID4g
SWRrLCBlaXRoZXIgd2F5IGlzIGZpbmUgd2l0aCBtZS4KPiAKPiBUaGVyZSBpcyBpc19zY2FsYXJf
YnJhbmNoX3Rha2VuKCkgaW4gaXNfYnJhbmNoX3Rha2VuKCksIEkgbWlzc2VkIGl0LiBJJ2xsIGEp
Cj4gY2hlY2sgdGhlIG9wY29kZSBvbmUgYnkgb25lIGluIGlzX3NjYWxhcl9icmFuY2hfdGFrZW4o
KSwgYW5kIGIpIGtlZXAgdGhpcyBwYXRjaAo+IGZvciB1bmtub3duIEJQRl9KU0VUIGJyYW5jaC4K
ClNvdW5kcyBnb29kIHRvIG1lLiBOb3RlIHRoYXQgdGhlIGxvZ2ljIGlzIGNvcnJlY3QgZm9yIGJv
dGggc2NhbGFyIGFuZApub24tc2NhbGFyIGNhc2VzLCBzbyBJIGRvbid0IHRoaW5rIHdlIGhhdmUg
dG8gY29uc3RyYWluIGl0IHRvCmlzX3NjYWxhcl9icmFuY2hfdGFrZW4oKSAoZG9uJ3QgdGhpbmsg
dGhlcmUgaXMgYSBuZWVkIHRvIGNoZWNrIGlmCnBvaW50ZXIgY29tcGFyaXNvbnMgYXJlIGFsbG93
ZWQsIGFzIG5vIG5ldyBpbmZvcm1hdGlvbiBpcyBpbmZlcnJlZApmcm9tIGNvbXBhcmlzb25zIHdp
dGggc2VsZikuCg==


