Return-Path: <linux-kernel+bounces-834246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10ADCBA443D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 16:40:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0A33B6022C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 14:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A7C128695;
	Fri, 26 Sep 2025 14:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bJBXES1L"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB7EB72605
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 14:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758897451; cv=none; b=epngoCK9jeduTQ+O6hn0L1h4Cdkb7GU9999W/LAHMBrIcIoN6lREQKc0iKW90YR30hcthgwF55BjjfsTpajalGz+B3r355bMtGwWqD1Y4s5r9tbW42ahfROh6WhSVZZ8kGKOBw5MosrV4HCncGUMygNktJMWE6HY6Br5BOrjcgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758897451; c=relaxed/simple;
	bh=ZLYIvEVdYFtaxQbaBOf6ThGMjn/MwBnMXEGHzdAzS1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KTmWxV7Xpld1U0CDftWndVU7YixTqsgnyt2NX8+HkAVJB6M1cRP2n1DNdp+XKCSsvUdaPDUtlMchUYEPdrAezUG5U3zucNe7B03twH3yAL1QAOEw9dtvOBbIoiltFGgysZROssjrl/2Mt1rVzfLCxlrWuPhfGV5MOa6xCj+KdXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bJBXES1L; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758897448;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nNHZdA2ynNJGHBH8wutoba5JHt6T91gjLDofejClBRE=;
	b=bJBXES1LIw1pCAGp8bBrtls/UXkazCEVcLoM3PK4wVVC1swlcZY4RyaYCps2CoMQF1Yr2P
	XqHZYJGB3S2X0wCAaBMbZ0knfxFNDQVq57rFVtwASR0A4K4dTQVFSbjbisI4DvoOCCSZvH
	TxWffQs0IbLKy6FsTgLNZf7Im8Jb9V4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-_Tg7wVYeMqeQ06eV_zDTeg-1; Fri, 26 Sep 2025 10:37:25 -0400
X-MC-Unique: _Tg7wVYeMqeQ06eV_zDTeg-1
X-Mimecast-MFC-AGG-ID: _Tg7wVYeMqeQ06eV_zDTeg_1758897444
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3f924ae2a89so1912197f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 07:37:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758897444; x=1759502244;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nNHZdA2ynNJGHBH8wutoba5JHt6T91gjLDofejClBRE=;
        b=jMZ7tc9Trgz+BilROwsDD3hmsgT6zg9QAwhx23LfecVljceqyuMZL97PfU7MQazVTh
         fVn3avpu0e+VZKXebTHfF+Bl9wZD9xsbxwmm8Ibz9+nglriNBTtQFmimEQ281pMMrMY2
         BKQh8E+v6ASoWRoYfbR4MDwhTvXZZq1Da0e34LoBM8Tt5WvuF5BO85p6y59sdr3mEYKu
         +1MQH8tIhWY1B95P5QhJGs97iQcQ20pA7man34PhyEmlALKniDQBP4N4WEupi2cVHLRM
         R4Hbq0tVL2nWZSTXpYLknFYJs1NXRFTjz6ZxypwU0HiHTDuBxUSQvKxSXN5PyXgsq/8m
         Qdlw==
X-Forwarded-Encrypted: i=1; AJvYcCXYMVccistWiE8EAN1UG0KZUVmWbCOZSIakJ4Sy+efxJxGINXpxmlkooyG7xlPmlSSVPm2Vu1J/dvsEjig=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz65xq9i3uNMB7Doq0H4gtoSw5HhQI9PBrCu8v+LSMYxnQvkfy3
	AA9MLssCK4qVkLnkU+zeMjBnXROOSwUhO1ppUBOyZj4nmg7eOEAJoKgWQtcpfuZ6F+gncpb3IX5
	4uR7tME8upmxCaK3X0V4XYCfnlSeGMmxzeimYFb1vOyaqqK7Kq9DJ9/V2MCuKubrqFA==
X-Gm-Gg: ASbGncvA9L+aY/Vtnl/i/Q+CIM0Mfe40Sh4AnwqxF7SO217gd33E3Y8zH4mhLiz5m89
	4nHdrnsCQnCd0asO7B3AnPUaa6q6OYIymiqcOt4MBo4DPB9prZv44pqM10tLOIbfpNzbJbEDSVV
	oORQk7idGwBW3BR9qUDukyPvIQl5A09e6/jaQxyoP4A06hGZHl6Nw/WzRSlhBVvZ9WjCp7u8y2A
	AqIrcOSLu2eeICb1O5ze7MYUO2Pfc5pYihTnl3b7D9bhhE0RslFV2Cn5pH16rj6KPjg5+Fh0DbE
	O9fKTRMvjHAtftNJaIqoIPAyvYdNGGKryGI=
X-Received: by 2002:a05:6000:1869:b0:3e8:94d3:766b with SMTP id ffacd0b85a97d-40e468e73c8mr6983290f8f.1.1758897444338;
        Fri, 26 Sep 2025 07:37:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXwmeHtQqcwnjJIme2wTxfCuczMPQ8tCMq+UMmG5Eh2oYtKsbn0VPkmA3WWKpKwuGGfPj1GA==
X-Received: by 2002:a05:6000:1869:b0:3e8:94d3:766b with SMTP id ffacd0b85a97d-40e468e73c8mr6983257f8f.1.1758897443747;
        Fri, 26 Sep 2025 07:37:23 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73ea:f900:52ee:df2b:4811:77e0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e33bf6ecbsm82911155e9.22.2025.09.26.07.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 07:37:23 -0700 (PDT)
Date: Fri, 26 Sep 2025 10:37:20 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
Cc: Yongji Xie <xieyongji@bytedance.com>, linux-kernel@vger.kernel.org,
	Maxime Coquelin <mcoqueli@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Cindy Lu <lulu@redhat.com>,
	virtualization@lists.linux.dev, Laurent Vivier <lvivier@redhat.com>,
	jasowang@redhat.com
Subject: Re: [PATCH v5 0/6] Add multiple address spaces support to VDUSE
Message-ID: <20250926103421-mutt-send-email-mst@kernel.org>
References: <20250926101432.2251301-1-eperezma@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250926101432.2251301-1-eperezma@redhat.com>

On Fri, Sep 26, 2025 at 12:14:26PM +0200, Eugenio Pérez wrote:
> PATCH v5:
> * Properly return errno if copy_to_user returns >0 in VDUSE_IOTLB_GET_FD
>   ioctl (Jason).

???

I think copy_to_user returns an unsigned value: the number of bytes copied.


static __always_inline unsigned long __must_check
copy_from_user(void *to, const void __user *from, unsigned long n)
{
        if (!check_copy_size(to, n, false))
                return n;
#ifdef INLINE_COPY_FROM_USER
        return _inline_copy_from_user(to, from, n);
#else
        return _copy_from_user(to, from, n);
#endif
}


so, how does the patch work then?

-- 
MST


