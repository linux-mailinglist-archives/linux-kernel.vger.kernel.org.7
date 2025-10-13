Return-Path: <linux-kernel+bounces-851283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C0A9BD604A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 21:59:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AB1424E43C1
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 19:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4C2B2DBF73;
	Mon, 13 Oct 2025 19:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S2Ogd+vr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312F22D839D
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 19:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760385547; cv=none; b=o7n00UEy4ibmwEdlSbOv5vuNKfSb0oLRCoSdg1Ua/pA+LXyvgnm6UJKcof73BT0+imT9Wn1lbfXbL9gKYaC+9sAV2VRfp6B5RB7AYSHuA8w7KTAQlTgdlnYJjFAWIONLR8pQNUJIGd95eYsB21bzxqnWxOI+cqCCd240u2V4cjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760385547; c=relaxed/simple;
	bh=sezSXOJQy2e1FfQT3DvAibk3dsRjxgWqO6zkN/PeAc0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TiNYZ8fAfcqYBHdCoAqpMchblS2YYQrchdEoK91AtWyE7C4RGqsnaFWvBr44jlGxSeNhDrtxBgopkdFPmkGWCRhDzprzozQvSvHUJZYiOg4arkeE/aCUlOjsZOR453IKSTLNBtkwfu0k2+YLKH5lfeG1e+ybQHK/gojeiVMp+jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S2Ogd+vr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760385545;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=cNYrRRv0UVpj7OF83STXMa0S0+9wdXsPDfsjLG00SV8=;
	b=S2Ogd+vrch0AhlRr0xMhOasUyhTFrCel/O2dqWA1fL/HpJJue3SydZztIP9IJS8Q/4W/JN
	pA3OBtp0UpvJtlCJB8PhnuyhYrt1Yz9msPkfm2F38Bonjav8s/bAZvCF0zp4GT0ATFdPRC
	e5Cfw0F/9HaKS2ZZF17Da/GpVTcoT40=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-198-s2SbdvdaMSKxi2OrP-G3FA-1; Mon, 13 Oct 2025 15:59:03 -0400
X-MC-Unique: s2SbdvdaMSKxi2OrP-G3FA-1
X-Mimecast-MFC-AGG-ID: s2SbdvdaMSKxi2OrP-G3FA_1760385542
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3ecdc9dbc5fso3466540f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 12:59:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760385542; x=1760990342;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cNYrRRv0UVpj7OF83STXMa0S0+9wdXsPDfsjLG00SV8=;
        b=lu9sOSFFLhJ3VWRTLu/PWD7tVQtwMedYS97opzsz7p0vM+vE8+qXqUa/NVeYvBEbaZ
         R4aRgfl+K2vyaXecMjDpIl7ZiCfvlKVaYmS/RA5pRc2cf/ny1OzjcpTV90sRRvN9X0Ay
         r+XGVmCssuUGNgUaxQeFJy3ozlJ6ocEircFYECf+/V/MEoUkl6pCcFbc2u3pBMtHGK/P
         ixsyGc+HHUHcbKLGXb5/uk/5+8mBKvG4UYdEVhYiL7IQibQBez0ClC6mhizn7tVSrw/2
         Jw/IKXiDFGNmafJICV1aq2IDAAABrO4HC/JMEV4UR5GdrEWXGOCIx9AyVvm9DhjblJua
         1bkA==
X-Forwarded-Encrypted: i=1; AJvYcCXU8pj7PTuqzIzuaN+Uu1O8b0YTxILtygg3cOY+o3be9nSm3IjSi7QnguWbswD8vxfhyyYRDrGeA28dEXI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdMd1D+lk4r11yDi+yUAG/fQkVz9wyWaSgdiFUwbZnNjdma1vz
	2BYnbDCDc9QCPoEptEfCacGqFiVa1Y5HwOUZpqA78k+z40a43MoEeRv2/3WS8Xk1hpH2Q19n+GB
	fSM9/SG9NHfi7Q7l4CfG+C5ocLnEdcrD5J3ZmZ193WSQ5Ml1Vfu04Fk890qyi6i7HzSFA8VzGTw
	==
X-Gm-Gg: ASbGnct2JYn1BJL8U0ze4MLzs7EolIL+q2TjpNVqCqjazanxaHlVcISBCdaCKHOvAsC
	/RMcmYZ0fp945tUbfYxXtSzVDdrxSZLnzpEPBgSaL/GatvHJizT1ByqosCEDYHpsTYyd+35b1m7
	dCHUbQCheA0uLryCj1GxJpGlvuwxVxFmZvFYWKIZVPRH7LYxfdbiJoay4sQ7/lUJUN539GHvNU9
	latYydZnTj63bQmshCw7/Lb2IVUi+mk49lQEsydxCKiNZA4Ej1o5QRTjryC3fjkIFfTwojEpo0E
	V6djSG2WTPa8JKSf6U7h/3V8LNDrc4BJ+4Vv03KcTHqqHfqa+A1B5/YMBahvJ6Qg5xyrrNSDLyW
	sifM=
X-Received: by 2002:a05:6000:25c3:b0:3ec:e276:f3d5 with SMTP id ffacd0b85a97d-4266e8dabeamr14498750f8f.42.1760385542144;
        Mon, 13 Oct 2025 12:59:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGvpCF44kQW5Htm2GFpYxYfXyTl5+0TLHHcYsSHm1UZ8A4aEwGaAWQh2xxcjFLKzYXV6CxPHw==
X-Received: by 2002:a05:6000:25c3:b0:3ec:e276:f3d5 with SMTP id ffacd0b85a97d-4266e8dabeamr14498742f8f.42.1760385541739;
        Mon, 13 Oct 2025 12:59:01 -0700 (PDT)
Received: from [192.168.3.141] (tmo-083-189.customers.d1-online.com. [80.187.83.189])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce57ccb1sm19843079f8f.8.2025.10.13.12.59.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 12:59:01 -0700 (PDT)
Message-ID: <26a8f0aa-8d67-47ba-841c-2daf7010a2aa@redhat.com>
Date: Mon, 13 Oct 2025 21:58:59 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Regerssion] [KSM] KSM CPU overhead in 6.16+ kernel compared to
 <=6.15 versions ("folio_walk_start" kernel object overhead)
To: craftfever@murena.io
Cc: akpm@linux-foundation.org, chengming.zhou@linux.dev,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 lorenzo.stoakes@oracle.com, regressions@lists.linux.dev, xu.xin16@zte.com.cn
References: <80b153cd-8bba-4bcd-9b56-3b2ad3f295e1@redhat.com>
 <46d26246-5bd5-43f7-b1a4-dc721f717413@airmail.cc>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <46d26246-5bd5-43f7-b1a4-dc721f717413@airmail.cc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13.10.25 21:54, craftfever wrote:
> 
> Unfortunately, yes I can reproduce it. And I thought that lockups does
> not happen anymore, but I was wrong, I booted today with 6.17.2 updated
> and KSM enabled and whole situation is back. But, it only happens, when
> scanning pages corresponding to a process with huge VM size, like
> Chromium with 1TB of virtual memory. The rest is alright. It's look
> like, that the folio_walk_start called with much higher frequency, than
> in 6.12-6.15 versions. in that version page scanning of huge VM size
> processes is pretty fast and flawless) Right now, when Chromium is
> running, I expecting constant 42% folio_walk_start and 15%
> ksm_scan_thread on 6.17.2 kernel (contrary to 1% folio_walk_start and
> even less ksm_scan_thread in 6.12-6.15). I must admin that whole system
> is not freezing, just Chromium with high CPU usage from ksmd and kernel.

What about 6.16?

-- 
Cheers

David / dhildenb


