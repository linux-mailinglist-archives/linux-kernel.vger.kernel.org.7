Return-Path: <linux-kernel+bounces-835471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 847B3BA73B6
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 17:17:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC14A1896247
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 15:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 935BB223DE7;
	Sun, 28 Sep 2025 15:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hUn5wQVX"
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A05B27707
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 15:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759072654; cv=none; b=GN284gIa+gLsw5QLsAaXin1P6ytL48/KZ0cCtouOxbbdHO/EkwdsjohdbF3uxzbqPCTdpNgeyo2EslGW4cTQ+qD2NKVyozkbENuuzAbuf/9JIWn0GK7E+LislydM3uiT1x0e+AUat2xv+Ny+74vN4jaaguPeK6i4IOYuhiprPeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759072654; c=relaxed/simple;
	bh=gNKSetNlSBaBKHWx6dCZg9eil+3R4RosFQhrPYIVI1U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TXATyJTlYC2kkmxOAGy3P2eJaR9mH+c7kP2IhlN9tFjxnsf5kq7lbD0/i6Iv/5UHyScsX2PaRtSNAtYEH1+0MGZj2cIxAjvgZqcXniF4rICzRaQ8bJUYYfNnAMlZHzPUVc9Ys0UOtrzyjZeNMZu9V8rSjzsasgfLTiGZkyJ/hDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hUn5wQVX; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-54aa789f9b5so2691152e0c.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 08:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759072649; x=1759677449; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+vqHkUy8fuyVbj5suFT081UY64ZPTEl5grQdmncLLbw=;
        b=hUn5wQVXxq867EDM6Zs71FwQN3RX9rrnAPy7JtlHz3nxGJncIyX6seQAk/GoewO7O/
         ErdsZeZ1ZwAs3nmkzDkmxGmTG27E+3zBC0yl9Qyf3dTbs+bxgzgEgmbVA7WxZlLwGNnF
         +Y5k12VO3IFlrKMEbT6pVNadb+XEgaLTbd/eB7nnzRHwx5vr7Y9EyFHoS0xx+Nj/Qflu
         kvlq25BNb1EP+CuO7iVu9d5VQx5cBrNrHqoxTwb3sKZMnosDPVS7og9CdoIrbBD0haml
         Y9y4G1FS0QvRxpTd7GP4jY3SYXxquKc7Woak0x45WmRNRcTO5kprJCPD3PqfeTOLaoAE
         m4vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759072649; x=1759677449;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+vqHkUy8fuyVbj5suFT081UY64ZPTEl5grQdmncLLbw=;
        b=hdXsY4ZVnCDRYX/6yITvFG4fcSmeW3ppDhOgkR7m/JyTbNl6FioLf/2Ls28GQCbB7O
         rD41bJZ9sUYApZQ+wFZqAmFsuCK5ip4oT/Sujkp36mclhduRdyuTnQgW6EmdVFtmUcY1
         x8bTk3EV4rn1P1wN1RMd9lyFyu3z9x/qOmYDioob4QH0o+MPpLEGOUgnEQyUlz38wl6C
         N2gDLcj+FzcY+icBFhKVY5xS4oo8MNtc9ZF6VIzb4iNdUh8Bk9AWVjrNtfO2QHKxBV6z
         z5hp+3EbqncXs1/xNRkgqmX2qBThTxM5AdUysybks7s80kvaL0oCDnhvvpm1qSfOJB8R
         ebfA==
X-Forwarded-Encrypted: i=1; AJvYcCXZCcw2pgu0QSw2z8TidQy5yQW+G9k6xUrLOeNgobp+VlT/QJlurys2qYZmpAjW1kROOIXiGLXKJz1t5s4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwK/rsDPmwmVvX6XCzcmqzxsvdAV94UUIghi+mc0wRoe6oT0if2
	S8Ku4IWlT1cjpAZcIlrJg72blws/nrbvRFwjCtBBYzDWE1niIF70R9G/
X-Gm-Gg: ASbGncvknfJGQcnujef+SkIOIOKqxJEZC6cAeGcScEcoG2QzlYkX6/CuCRtnQdA5rTX
	QC2uboaAYNXy5PKxnX+AjVbxndQHKLTd1H1rfYsmI+32+G48oCGYubvqiAXwxF0U5PsC/7wA6nI
	L4RKN411rVD1Clr3SVAcT87IbHVl0/bxM6CflRXoDlGOiFt5Q+O4/jjU2uSrp8JY3Q2bObQDFmC
	hQc9UXNpnQbb52bPXk8HEpPQ9mm10+Kkvmh/OSnFf+J6nLJs9xsVsdHsTBimpS+OiQdNP7BYz9u
	p4HM6WePKZdQSftVfQ5NRy0lpeJDiQImAYqy7gHA+evDkQXqXuafp7yUcrYfrTakn06JnH639yI
	PPoFUMvMi/phDZaIeWsoHTaWtVItU6s5BSYrD2Vg=
X-Google-Smtp-Source: AGHT+IF8pnH4LYbG6wywYAE+rCN8FpqtNuwStfp46rg0IEu+rwT49OwVM0C6uY5V1Kl8rA0DIg5drg==
X-Received: by 2002:a05:6122:3109:b0:54a:8690:719b with SMTP id 71dfb90a1353d-54e6086099cmr290197e0c.11.1759072649431;
        Sun, 28 Sep 2025 08:17:29 -0700 (PDT)
Received: from [192.168.1.145] ([104.203.11.126])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-54bed8a4e77sm1806934e0c.10.2025.09.28.08.17.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Sep 2025 08:17:28 -0700 (PDT)
Message-ID: <56d8cad5-d8ab-436d-bad0-c631e414c70d@gmail.com>
Date: Sun, 28 Sep 2025 11:17:26 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ntfs3: fix uninit memory after failed mi_read in
 mi_format_new
To: Raphael Pinsonneault-Thibeault <rpthibeault@gmail.com>,
 almaz.alexandrovich@paragon-software.com
Cc: ntfs3@lists.linux.dev, linux-kernel@vger.kernel.org,
 skhan@linuxfoundation.org,
 syzbot+7a2ba6b7b66340cff225@syzkaller.appspotmail.com
References: <20250925203701.223744-2-rpthibeault@gmail.com>
Content-Language: en-US
From: David Hunter <david.hunter.linux@gmail.com>
In-Reply-To: <20250925203701.223744-2-rpthibeault@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/25/25 16:36, Raphael Pinsonneault-Thibeault wrote:
> attr_insert_range() called from ntfs_fallocate() has 2 different
> code paths that trigger mi_read() (which calls ntfs_read_bh).
> If the first mi_read() -> ntfs_read_bh() fails with an IO error, it
> leaves an uninitialized buffer in the buffer cache.
> The second mi_read() -> ntfs_read_bh() then uses that buffer,
> where we get KMSAN warning "uninit-value in ntfs_read_bh".
> 
> The fix is to check if mi_read failed in mi_format_new.
> 


Did you do any testing for this patch?

David Hunter


