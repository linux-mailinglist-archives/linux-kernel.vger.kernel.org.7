Return-Path: <linux-kernel+bounces-849056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 68AEABCF18D
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 09:53:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EC4FA34D5BF
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 07:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B65C229B38;
	Sat, 11 Oct 2025 07:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sJQtuQlC"
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEBA3149E17
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 07:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760169192; cv=none; b=GzkPmQnEtewg4w6fq5ECv8Oa5pVBEYtFhgqIzwOPjPtoezfdW1QvNW16EtChMNYoPr7trle5l6/nz9gU9UUz4DACNsCMWP3kXPAu+cOz1mBsey68fPXsf3GBP1SOCyksEWxxjp37Y0kP/Tbs8D6jEQezXbgl8PM5oIJtxsrTvWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760169192; c=relaxed/simple;
	bh=VWvortduSgLOuSJJ/U0S60TCcSUgKMFRvqEyQv7retc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o47a/WOtT5C3p/L1RE6INyEAjjNI7CqjnQ++N3TfzEBtIEGpGw9IlEgoEFzPV/IjEB3h30CLdp+tbvWD4zRUjAq3uux7GkzYiGV2gmiemIj5Pd554ZfRllWj4mSw8qddzQ81lGUyKDMOUR/ob2I/gOK9+evOLiE9ZM2enfOvJ7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sJQtuQlC; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Forwarded-Encrypted: i=1; AJvYcCVPHRJxf+JQnYUiJpUfgTgMoYLPeIbH6LmgO7f+wF0aQgIPFsaTMbKDbbkg8ulmh/55rYvz8r5BefxLvVU=@vger.kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760169185;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VWvortduSgLOuSJJ/U0S60TCcSUgKMFRvqEyQv7retc=;
	b=sJQtuQlCpMAImZcRW6iQh3gvN+2hC0Pw1KG3vJLefIFRDA4KJ3ZVDewRd09OvCHbABLf3P
	Ci+mgEaOCwv93mzGGt5Uh243+Esr94r9xVlpOYU+ZjeTggNpj59HDq0hvqMjsXe7kIo9zV
	lxQNaC1nPwKASDCYHOxyCrnP9U2trpE=
X-Gm-Message-State: AOJu0Yw9eO4D0T8bFPle9OGZ+4OE5RMaKEC/nvJekN0XZSVsxRv3A0bn
	djFVpVC2PAwST5JfC43SE9A9WrMKicwPxt4ZK6x05XepXOg6nCJPTS6fuE9Et2FpozxZcYomHoB
	PIO/NlsKlGHX5dEjuGKS8SIebim/RE+A=
X-Google-Smtp-Source: AGHT+IEL6m6ytVdwMmFOmFWKjL3kcfzvMyZdNcU/AX8xGP/3bnSV/FhnIWrS8KRjUUXicdKxpouZcuEji+pMNJPmlHg=
X-Received: by 2002:a05:6214:4004:b0:766:ab7c:3e89 with SMTP id
 6a1803df08f44-87b2efc373amr198459456d6.64.1760169173408; Sat, 11 Oct 2025
 00:52:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251009070045.2011920-1-xialonglong2025@163.com>
 <20251009070045.2011920-2-xialonglong2025@163.com> <CABzRoyYfx0QPgGG4WYEYmT8-J10ToRCUStd3tWC0CtT_D8ctiQ@mail.gmail.com>
In-Reply-To: <CABzRoyYfx0QPgGG4WYEYmT8-J10ToRCUStd3tWC0CtT_D8ctiQ@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
Date: Sat, 11 Oct 2025 15:52:16 +0800
X-Gmail-Original-Message-ID: <CABzRoyYK38imLh6zN2DZKPRyQrJkKyvpswqJAsWzEeECtOxaMA@mail.gmail.com>
X-Gm-Features: AS18NWDBvflbwRJ04Gw6IWuF9bLxakSMQiCM_NYehBhsrI7LnFT20xyrjWwbYmM
Message-ID: <CABzRoyYK38imLh6zN2DZKPRyQrJkKyvpswqJAsWzEeECtOxaMA@mail.gmail.com>
Subject: Re: [PATCH RFC 1/1] mm/ksm: Add recovery mechanism for memory failures
To: linmiaohe@huawei.com
Cc: Longlong Xia <xialonglong2025@163.com>, nao.horiguchi@gmail.com, 
	akpm@linux-foundation.org, wangkefeng.wang@huawei.com, xu.xin16@zte.com.cn, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Longlong Xia <xialonglong@kylinos.cn>, Lance Yang <lance.yang@linux.dev>, david@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Migadu-Flow: FLOW_OUT

@Miaohe

I'd like to raise a concern about a potential hardware failure :)

My tests show that if the shared zeropage (or huge zeropage) gets marked
with HWpoison, the kernel continues to install it for new mappings.
Surprisingly, it does not kill the accessing process ...

The concern is, once the page is no longer zero-filled due to the hardware
failure, what will happen? Would this lead to silent data corruption for
applications that expect to read zeros?

Thanks,
Lance

