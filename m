Return-Path: <linux-kernel+bounces-846885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2A1ABC9558
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 15:37:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF09A3C1298
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 13:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8726B2E92C0;
	Thu,  9 Oct 2025 13:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QXmhDU9I"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0B62E8E0E
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 13:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760017050; cv=none; b=PVuP6uQSaVhGOs3XGVLNsxrtpoVC1R36WaBqWlyhvrvjSusk0ViDVI0FnzBc2btMM8bK5T0oG3Tz6xCFOPUbFOtmkQPIcxeFUYWPiUF3A/8Y2IO/uDaPQhAEHlQ2t27S0Gs0Q9xJHB+HFBOt2FVlkLgfE3McHPyu4e7yF4n6W5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760017050; c=relaxed/simple;
	bh=7NdTvvUFK/WVGSYlLXsbwdrwKPNZwb8MV31/iuYNMko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=atq2ixYj19gyGNjevcxz6l9yisxF2TiyRuRhXzB5zC9U6d4GlRHU1ZglQ34Fb62f9wcaYJyFDY3QlyjkLSvJPG3DV3Brb8p3Zd6GibJAkTwcchVhx626DzykMorMQIO6KUC8ujN/5Ba/SU9QMfPZt9bblEbbDfXSAlfQakJYVhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QXmhDU9I; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760017048;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QSnlK9qf9+QtrbFfXzTXGo8du1cPFojIdvhyIWDFaG4=;
	b=QXmhDU9Iet5vhAhr2qWm8ezr/UGEp076xcPaTJK3wRz9iGiO0tWUJuTZzA3rnr+Ci2TiEN
	3BECBE4Z26fGVVO8d0TtGQRwztXDCPp7dCWtsLjtlbCkDAJDXrD3BO/HnSBs08Cx2xd2Ak
	IQLUgEWGpwmOhkHUPnNXTbYdWcdkEP8=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-3h-DytUTMdW3GGyAY7lZTQ-1; Thu, 09 Oct 2025 09:37:27 -0400
X-MC-Unique: 3h-DytUTMdW3GGyAY7lZTQ-1
X-Mimecast-MFC-AGG-ID: 3h-DytUTMdW3GGyAY7lZTQ_1760017046
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4de801c1446so31409531cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 06:37:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760017046; x=1760621846;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QSnlK9qf9+QtrbFfXzTXGo8du1cPFojIdvhyIWDFaG4=;
        b=DkdX3LeHeNi4/B4wg/n3g/QKxzhCx+etn51ulRCcEEIJ2QHQ9i7pM98ly+6oO79g3u
         3peiM4TBHnHhGfEo10M8kTJN7ouQtLnGADHarJYXaqKTi84Bxq12UW6UhMs5LJAehIv4
         YChANALMphZkWTmq8k2ZTn+8WSXXWVddtnr0pgMUUq7OcToibY63JHMK2qJkP5QrYy7I
         qePeUkDGf9ByfiQyc9XScAidNHsweRQ8rWmKizKBkTQ4txRzGWDGqJf4eitOiRlM1yon
         J+hOwAC5/doWHt+Fkx+p3VJL12Cs2C2/9iFDhOY8gP0DNtA3mIpmE2uJkyye8IeapORo
         Bqfw==
X-Gm-Message-State: AOJu0YyDUXq3TyF5S0BUyWFDHYayXfpDF/cYMZXKUuTXTaw6HbnUl1Mn
	NOEBDRGQ1rPv7VM5OBz0xnz9PIYjiftOtmIU8FOgy0bowzQci3e1q7ksMX9IXdyY54ezDpu0+8t
	Gnam1hGk9o4SUyNst9HUy2/Nm4bF93Wbw/I7D6K7cFIdHB9oQzJlG3+n+6+8Ymmu2gQ==
X-Gm-Gg: ASbGncvV30RSOWLqT4uDpnDvALC5RW4BKyKOqWIRYEVfi/AB+Wl/N+/WldT2fSWa8U8
	AtMSQCcAEfV0HZkJzVmJFYpp0bFERfReTHtwdj4pi2YIsQwqAZyJIhv/5jG/qyTObMYXJegYjTN
	MjWDP2s//kwg6UId32LITxFKqU0Z9BqLHVlYhPRexnBOzYJ6LQyUqCJQc4tPxLPqjK5jw8JBFD5
	noKyAxUllsqbCkaQgEfXSX6x5XONQ/Q6tzFpO9B7ha1PY96JluoyfQWhdf0i7LRxSzsqKmpaj0E
	Zr6k51jZBc70otuijP8hfAxutlQRIKGEQTM=
X-Received: by 2002:a05:622a:552:b0:4d3:1b4f:dda1 with SMTP id d75a77b69052e-4e6ead5b74fmr99238151cf.61.1760017046382;
        Thu, 09 Oct 2025 06:37:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGkkkln0wvJVfA+/SQdl7KyNaqeghASgRMRgQSZA/6yVrMeWhD/2djQvFf88sK4uQV3LAnLRw==
X-Received: by 2002:a05:622a:552:b0:4d3:1b4f:dda1 with SMTP id d75a77b69052e-4e6ead5b74fmr99237541cf.61.1760017045789;
        Thu, 09 Oct 2025 06:37:25 -0700 (PDT)
Received: from redhat.com ([138.199.52.81])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-884a2369b3fsm191330185a.51.2025.10.09.06.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 06:37:25 -0700 (PDT)
Date: Thu, 9 Oct 2025 09:37:20 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Jonathan Corbet <corbet@lwn.net>, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, linux-doc@vger.kernel.org
Subject: Re: [PATCH 1/3] virtio: dwords->qwords
Message-ID: <20251009093127-mutt-send-email-mst@kernel.org>
References: <cover.1760008797.git.mst@redhat.com>
 <350d0abfaa2dcdb44678098f9119ba41166f375f.1760008798.git.mst@redhat.com>
 <26d7d26e-dd45-47bb-885b-45c6d44900bb@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26d7d26e-dd45-47bb-885b-45c6d44900bb@lunn.ch>

On Thu, Oct 09, 2025 at 02:31:04PM +0200, Andrew Lunn wrote:
> On Thu, Oct 09, 2025 at 07:24:08AM -0400, Michael S. Tsirkin wrote:
> > A "word" is 16 bit. 64 bit integers like virtio uses are not dwords,
> > they are actually qwords.
> 
> I'm having trouble with this....
> 
> This bit makes sense. 4x 16bits = 64 bits.
> 
> > -static const u64 vhost_net_features[VIRTIO_FEATURES_DWORDS] = {
> > +static const u64 vhost_net_features[VIRTIO_FEATURES_QWORDS] = {
> 
> If this was u16, and VIRTIO_FEATURES_QWORDS was 4, which the Q would
> imply, than i would agree with what you are saying. But this is a u64
> type.  It is already a QWORD, and this is an array of two of them.

I don't get what you are saying here.
It's an array of qwords and VIRTIO_FEATURES_QWORDS tells you
how many QWORDS are needed to fit all of them.

This is how C arrays are declared.


> I think the real issue here is not D vs Q, but WORD. We have a default
> meaning of a u16 for a word, especially in C. But that is not the
> actual definition of a word a computer scientist would use. Wikipedia
> has:
> 
>   In computing, a word is any processor design's natural unit of
>   data. A word is a fixed-sized datum handled as a unit by the
>   instruction set or the hardware of the processor.
> 
> A word can be any size. In this context, virtio is not referring to
> the instruction set, but a protocol. Are all fields in this protocol
> u64? Hence word is u64? And this is an array of two words? That would
> make DWORD correct, it is two words.
> 
> If you want to change anything here, i would actually change WORD to
> something else, maybe FIELD?
> 
> And i could be wrong here, i've not looked at the actual protocol, so
> i've no idea if all fields in the protocol are u64. There are
> protocols like this, IPv6 uses u32, not octets, and the length field
> in the headers refer to the number of u32s in the header.
> 
> 	Andrew


Virtio uses "dword" to mean "32 bits" in several places:



device-types/i2c/description.tex:The \field{padding} is used to pad to full dword.

pads to 32 bit


transport-pci.tex:        u8 padding[2];  /* Pad to full dword. */

same




Under pci, the meaning is also generally as I use it here.
E.g.:

Documentation/PCI/pci.rst:You can use `pci_(read|write)_config_(byte|word|dword)` to access the config






-- 
MST


