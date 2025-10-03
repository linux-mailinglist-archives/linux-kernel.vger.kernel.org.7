Return-Path: <linux-kernel+bounces-841452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CE06ABB7597
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 17:43:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D3E034ED387
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 15:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08358285CBB;
	Fri,  3 Oct 2025 15:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CTkxsBb5"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF341267729
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 15:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759506198; cv=none; b=V8WQLek8oBfk9QJywDiWewIfjUx/m+37XIj6oZb4WBKV2RVMIpblX6f/4UMVGQQzXdnBfPGbVTnBKe9FOjpYHElAwxm9w3v491T5rku/B2a/Jpns50wBul3TBbJfRj6e4fhS5mDWo8SLnE5uvx/nfDpT8IPfji1s7h9cq1x1snI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759506198; c=relaxed/simple;
	bh=zPkm8y04zTinG2pzfsV7xNelpFQ9Iy5tfKVIN/TNtTw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ix9HWdm3i4VaFAvk0rJUkCQkMm5b08A6uFDdGlh0ygCip3eTAQ7wTguN6keJ0KlZcfBT5lYtAyDnAmo3+eSBDW/qOqO8H5Ie+nJFuJnNts9fs57d/kWccTjGvyeILBG/dyXsNqyw6LK9lN1Tv62msL2OlBHsE1liI48hfx9ZsBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CTkxsBb5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759506195;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IRGVb+/SviQn0hYEk57O03Mjd4zlMdKn1zCsmQKmvak=;
	b=CTkxsBb5suA0oQfEnMG1bwUKYsNSh0aJx2KCVSyYBhRPZFgU2nYOXwxARzzkUqD2vTFX3d
	eAGn7XvI1i2isi5vTHjoDd4lpwLTUkqffqRfRAimmmDwN5rD5AlnhMggOziUBsclqu4NJ8
	eeCKDfbnLfM/jV8r7tl+Wf+SK449b+Q=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-167-K4kfysYMM1aen6jD4YSvzw-1; Fri, 03 Oct 2025 11:43:14 -0400
X-MC-Unique: K4kfysYMM1aen6jD4YSvzw-1
X-Mimecast-MFC-AGG-ID: K4kfysYMM1aen6jD4YSvzw_1759506193
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b2d1072a9c4so184339666b.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 08:43:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759506193; x=1760110993;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IRGVb+/SviQn0hYEk57O03Mjd4zlMdKn1zCsmQKmvak=;
        b=mEFflgn8f5g4BHfXXJnh/gBdWzj/VKhDjWfOtCUMcKZogRkiqHStDmH390rSK7ygm4
         zQ5KT0a7Hcb63MzuCbYuHyWPcGmy1qEVzwYDVPGubKhw78fPqskHyQ04h9qqXyMnEGcF
         HOBxz9ae8B5UURgW+d8LrUPt1Q/AvRfN9Am42gGOCp5Nt0fqfdrRWPoY6G4gwL1MTluW
         DLjJi44ND2U4BIJJHppqqUxUzY0UTgIqK28BTCWMkySDlyyqk1p2zOMs/dzDiiXRi3qg
         WQgsycD9kMmd0zbk8rggDDxeHrNe9QNdgwEKHiNbiLzN5mJDGR6YXOwTQAUtOdFh3Fbl
         Fecg==
X-Forwarded-Encrypted: i=1; AJvYcCWjRND0cEVpcwh4cHOFdOfyuFPYgU3pFMECFrJZZw/sVPqi/jrPD3tlQHii7wfSVKHCAuPvTBzgGBqw/1I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz351lHb09jrJF1Fa3AmU4zqZx/zNpThyV+jjGyK4ATH5J0e2tU
	Dwve01pnh6hCc7sdNZxjyleaxg/fWECCHJgro8wannHhcI3/8RsCIIiU2tkvxMr/Q0VGp4+uqw+
	KmbMNbECc+DFdDy2kJjOK6jBVeO3boIg7SdoKll4pKULUp1ZD5qYyijajdDILrUOx2eaNgBeKSs
	+v3tzpleLfL14x4xsFayUahmc9Vd2UmulR/Yj3ogbA
X-Gm-Gg: ASbGncvfRl8/QCcPtm8n1WWnIdiYi4q40tix1zwSQThk+NUVBGm3KqhPGFl2oZ6Xmm9
	JPFrVfpYv77ZfCWdVIzW9h4+Uf757KdpeIt8SEG0VELY6wDnQwwYqH++2niN6apNJPXSJAFFGxB
	9rhW5cLAqykkH4CxP0ee1J/9iTTQ==
X-Received: by 2002:a17:907:3d04:b0:b3e:c99b:c776 with SMTP id a640c23a62f3a-b49c1976ff9mr388878666b.15.1759506193433;
        Fri, 03 Oct 2025 08:43:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/hB+bqBiXabsgzDLKI0SAwaSMZqQiCYneHNLcJLgmVXqHx4mWWC5CZ27AQOqUH8EWfNPetcIXZgWFyZvMJv0=
X-Received: by 2002:a17:907:3d04:b0:b3e:c99b:c776 with SMTP id
 a640c23a62f3a-b49c1976ff9mr388875666b.15.1759506193040; Fri, 03 Oct 2025
 08:43:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250926193035.2158860-1-rrobaina@redhat.com> <aNfAKjRGXNUoSxQV@strlen.de>
In-Reply-To: <aNfAKjRGXNUoSxQV@strlen.de>
From: Ricardo Robaina <rrobaina@redhat.com>
Date: Fri, 3 Oct 2025 12:43:01 -0300
X-Gm-Features: AS18NWDHnuZbdmtwFCze6OYCQYsA8lH1vWwBn3WSoJ2s7xMRYWiXLVRdHRZKXSM
Message-ID: <CAABTaaDc_1N90BQP5mEHCoBEX5KkS=cyHV0FnY9H3deEbc7_Xw@mail.gmail.com>
Subject: Re: [PATCH v3] audit: include source and destination ports to NETFILTER_PKT
To: Florian Westphal <fw@strlen.de>, paul@paul-moore.com
Cc: audit@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org, eparis@redhat.com, 
	pablo@netfilter.org, kadlec@netfilter.org, ej@inai.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 27, 2025 at 7:45=E2=80=AFAM Florian Westphal <fw@strlen.de> wro=
te:
>
> Ricardo Robaina <rrobaina@redhat.com> wrote:
> > +     case IPPROTO_TCP:
> > +             audit_log_format(ab, " saddr=3D%pI4 daddr=3D%pI4 proto=3D=
%hhu sport=3D%hu dport=3D%hu",
> > +                              &ih->saddr, &ih->daddr, ih->protocol,
> > +                              ntohs(tcp_hdr(skb)->source), ntohs(tcp_h=
dr(skb)->dest));
>
> You need to use skb_header_pointer() like elsewhere in netfilter to
> access the transport protocol header.
>
> You can have a look at nf_log_dump_tcp_header() in nf_log_syslog.c for
> a template.
>
> Also please have a look at net/netfilter/nft_log.c, in particular
> nft_log_eval_audit(): xt_AUDIT and nft audit should be kept in sync wrt.
> their formatting.
>
Thanks for reviewing this patch, Florian!
I=E2=80=99ll work on a newer version addressing your suggestions.

> Maybe Paul would be open to adding something like audit_log_packet() to
> kernel/audit.c and then have xt_AUDIT.c and nft_log.c just call the
> common helper.
>
It sounds like a good idea to me. What do you think, Paul?


