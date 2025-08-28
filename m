Return-Path: <linux-kernel+bounces-789765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88DEBB39A28
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 12:36:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCDA917B3B7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 10:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44E7130DD0B;
	Thu, 28 Aug 2025 10:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VFUeQXis"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A6430EF99
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 10:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756377255; cv=none; b=m50mwbOVtNSBwY5U7k+DPOsK/tJnTb60ymrtZsJcQ3IO2ihJZhZIXrnIAD7HB5UWUngXgw58o4Din37W9UP8VEALeyU/15iHk+yHlMSW8VHGR/VfQevXbc5qjRAfk36yoQbqKXqUbsDwiml/ZELijFuxIPx0dH2xWkLQeUMSMxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756377255; c=relaxed/simple;
	bh=wtX1QaBz9wXYD4soHMyGal0DPdeF2TDx5Z3Sfo0JTI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S6mn1UDUiZdw7yM0euPIKg5eSxAR5B1zIzl5uk2p4LT8YEVk3CKyqm46OfkIsqNJV+cDks+yZk8X55Ef32FqqBlHVvGK0dt5sPCPEDKY9rzzSNIc3wNZsQJwVTzW/rb8+r9eTHVnKD/3W2p2Kjbh07E2qNCbtLOs0Oky3+VP/yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VFUeQXis; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756377253;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+FTwNA1bk0v6rrtoNJE35RPWClvjcf2jCc0VyKhrWjA=;
	b=VFUeQXisSoaKBse3MprQbSVksGa6EdizL4Zronbvrck23x/Ri5trRNehS3MLovvY1E9r75
	DttF81xQazkHX2Ba02PvOUHT01riPh4Kd8jZqTNMEqcbnlHgF0FccUViTzsA7RPwnesKDZ
	/ymAprv0kKbQ/rLzJGuGr6iGaB1aGW4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-1-0dh0RgMzy7A9NytP1Sng-1; Thu, 28 Aug 2025 06:34:09 -0400
X-MC-Unique: 1-0dh0RgMzy7A9NytP1Sng-1
X-Mimecast-MFC-AGG-ID: 1-0dh0RgMzy7A9NytP1Sng_1756377249
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3ce3e098c48so359369f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 03:34:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756377248; x=1756982048;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+FTwNA1bk0v6rrtoNJE35RPWClvjcf2jCc0VyKhrWjA=;
        b=e+3OK0YZFOpNThn71k2bYP0JzRkT6hP0CDd9OuscXVspiDegSqK4hdWjTABZPOp0Aj
         LZGLn6Dwnfna19l0LCNVlYvN8LccPd3fl8U2BYWudvLoneNXnSCMk+rPRFdo8p/1urcT
         cffATSZVpoph4IruRVbDi656AZQBJBfR4MZzxhuoqvFBlvBLIjzzbJnLYiK/m3UJNRlD
         zbf0iAjCYlHuwGuXjMeF0S8Rm5nevOPVKeN/VudbOuYkz0F0fzWgnH291dKoL4KEfCFA
         XHpg5Mot2EjoaN028FUS+lVamziP6OqoG/zXUI1MuoZ/JNk1E6rCwOTFQfLuwUgm3cWe
         FMhQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZBNn/2Mm0vnhu5Z203ccz5M0t6jQQwKe5STmxERG8l6qHS2QcfVZ3i+UuiSctQpNs5J2+GwRZsKCoeBQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOvYzMf6Rwwp97rwLWJ3Vpx89PuIB4OEZrJz8DLACNiIdJWL5+
	PvItDnuKY3XmH4fqAcGBnTtZeasADxOjC3nNowBinUzYEs01NFqxKLkLkCd8ikc5c6iB+fv6xXO
	a5SAWZ69i8/f2ZlBv4O/uFTsPloIR9zjSeQxU0s/4Y6iS3oyPlRzziS9PkIc8VhHnrQ==
X-Gm-Gg: ASbGnctt+vK+RYKm75ZcDuHtIdvv7Yk8UHYfXxytGjjxHLSPvy0ky4kLnZhEftWyxkC
	4zAdf0X5aZT9C7ue2jjBFOXnTT47rs6ORburvwRoC3J7mLyuLMQR5U/qG07OYjcWrPKcNhEkAw7
	Gm7nzzhARoSaIaXpPzJpEtHSd3A/gC9RhxkxZUAt27zJpTcQoIKCsLEuzJqcq2DKfMXF8lsYiHJ
	rt5EnnVXDnpZbbXoNoirmp3d+9gVlDU+ghAVGBwpGpt0meQznh8Jxol5+STvwa0jSrWlPRqUo/A
	C5iJtKp5+a+5duYxbWnReg96AUOng7B+
X-Received: by 2002:a5d:5f8e:0:b0:3c8:443:4066 with SMTP id ffacd0b85a97d-3c804434575mr12697629f8f.61.1756377248608;
        Thu, 28 Aug 2025 03:34:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG8oxOyBv4dBursJjsEHiDAvHkrowxoRe1iT8xj3dArCwD5U9uf5ibj+41tEIuHcsKWsgLqeg==
X-Received: by 2002:a5d:5f8e:0:b0:3c8:443:4066 with SMTP id ffacd0b85a97d-3c804434575mr12697598f8f.61.1756377248066;
        Thu, 28 Aug 2025 03:34:08 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1515:7300:62e6:253a:2a96:5e3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c711211e87sm23884597f8f.44.2025.08.28.03.34.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 03:34:07 -0700 (PDT)
Date: Thu, 28 Aug 2025 06:34:04 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Haixu Cui <quic_haixcui@quicinc.com>
Cc: andriy.shevchenko@intel.com, harald.mommer@oss.qualcomm.com,
	quic_msavaliy@quicinc.com, broonie@kernel.org,
	virtio-dev@lists.linux.dev, viresh.kumar@linaro.org,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	hdanton@sina.com, qiang4.zhang@linux.intel.com,
	alex.bennee@linaro.org, quic_ztu@quicinc.com
Subject: Re: [PATCH v4 2/3] virtio-spi: Add virtio-spi.h
Message-ID: <20250828063350-mutt-send-email-mst@kernel.org>
References: <20250820084944.84505-1-quic_haixcui@quicinc.com>
 <20250820084944.84505-3-quic_haixcui@quicinc.com>
 <20250821044351-mutt-send-email-mst@kernel.org>
 <1a63f5f9-add0-4a22-b01c-2f0c8d9efcec@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a63f5f9-add0-4a22-b01c-2f0c8d9efcec@quicinc.com>

On Mon, Aug 25, 2025 at 05:19:03PM +0800, Haixu Cui wrote:
> 
> 
> On 8/21/2025 4:45 PM, Michael S. Tsirkin wrote:
> 
> 
> > > +
> > > +/* Sample data on trailing clock edge */
> > > +#define VIRTIO_SPI_CPHA			_BITUL(0)
> > > +/* Clock is high when IDLE */
> > > +#define VIRTIO_SPI_CPOL			_BITUL(1)
> > > +/* Chip Select is active high */
> > > +#define VIRTIO_SPI_CS_HIGH			_BITUL(2)
> > > +/* Transmit LSB first */
> > > +#define VIRTIO_SPI_MODE_LSB_FIRST		_BITUL(3)
> > > +/* Loopback mode */
> > > +#define VIRTIO_SPI_MODE_LOOP			_BITUL(4)
> > 
> > It is generally preferable to have an enum with just bit
> > numbers.
> > 
> > 
> > E.g.
> > 
> > enum {
> > VIRTIO_SPI_F_CPHA = 0,
> > }
> > 
> > 
> > Userspace can add _BITUL wrappers itself if it
> > wants.
> > 
> > 
> 
> Hi Michael,
> 
> Thank you for the suggestion regarding the bit definitions.
> 
> Would it be acceptable to keep the current macro definitions with _BITUL()
> because these macros are also used within the virtio SPI driver itself?
> 
> Looking forward to your guidance.
> 
> Best regards,
> Haixu Cui
> 


move them to the .c file if you want them.


