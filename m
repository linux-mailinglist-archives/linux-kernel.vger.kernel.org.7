Return-Path: <linux-kernel+bounces-756508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8777AB1B53E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 15:50:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F03F1886BA7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 13:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7DFC2701D6;
	Tue,  5 Aug 2025 13:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="P/wq3biC"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A841A3166
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 13:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754401791; cv=none; b=sCAsPnRGvwcik8+MPWkDKAJDE0ehRInqxbAXJNEHhV4Xt7o2XLJfi3iXcoxSOp7f35bJ+qIyB+O4lcjv2xHR3kb5XSJahVJpuPqAJmZE42hPFhCy3HV+xc1i/iRD1oF205ap0E3kogPPogeUyV1tk0kTa8a70UcETbHz4Lzy1uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754401791; c=relaxed/simple;
	bh=xSf0T8NPt1UKhAqAic5exYt41gSrafSzFDLJUI/35cE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eooOqJ5i+6acPgj2P2PDbNI2Cq8vEnuYOAZKHGltEB6HFlRjnIUD23PfVhfZqo0E/5LhIMcbs8MaAJSeNP9kXHGHTUC00aClbTzcBGWUuVIBtTNBLiufrudFkvukATvIvFwLUSRYIv2DlS7/Ykwv4QhBP6DhHzJ2uf0GJS3Abyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=P/wq3biC; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-61589705b08so12031629a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 06:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1754401787; x=1755006587; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=l1IiCNwMbxf65Gn0A5vCk3b++p4e2fX7StqpL55rBUU=;
        b=P/wq3biCizIr4QCgcKhVv/D2OeD9MHdyNWTcOL8m4OMtp4d8OMTp2SbllgDiKq/OD/
         bnywr3arVk3od4yXnVzODwmFTfSX7P/gZWB2GMu8iGXdNhLMtlBKfFkzpfIchxNNKfok
         Kdl2LVsYQTDRCnP+4XwG5+8WduV64m+Ke2CbY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754401787; x=1755006587;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l1IiCNwMbxf65Gn0A5vCk3b++p4e2fX7StqpL55rBUU=;
        b=aDgKwkWyQHM/i2v8aoFua1gNukpRR7XciBA39bb0rM8EtQ3qb3VQTX/LTzpC8BmqMO
         6C6wVfBU3XqUAd+65uyLrpgrVGkuIkHlxHj99MXK9a7grze6yQehyKx7wyUMHm29HPM9
         FEZMzgSA1kG9VoJlurUUPzXYTzQH5MfSIEjmYOsS7BWP2ugQAdvrVMXFwRpkw/CPZVWz
         hZsRZkrmzeSqMSdQIui9hPJ5bpOk0c+6ny21X5z/sI6946qs4oxiFfyESc1yrdvAMY7+
         zd7S0f9rsDg03Vpv1ryWxXh9y9qGe6VuW2xvbzm+6fbEDkpVp7/XHknOErGUYM5RAtL1
         QC/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUrCDz4l/z0cSyDs0dTNtmWzHCo/JcrDsHVHC/ccC95FjJyZ3j67oZHlWtKMb/hRKJUfa4mJLo1RyyOLvE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyObRqv4PVOF6nMqp0sBHz4/0CBaYiQfmpLO6Pf40W+IS68VOxn
	07XblGejXOBlWBJtjoh1dFuuo4BjzGkLeH57m/hT3AJpmL+njxR8+dUWwLHgli7MkEuqsuXndBJ
	Ix2wpnb/NCQ==
X-Gm-Gg: ASbGncuNzgkvrE6yjjqX0JQkOXtrKfFC73vG3T07CBcogQt7v+6+PzWEyCCRG3gxobm
	KBxmJw/BQ9ijKQXNfCmonPPAp3JDpZ96CZsOEiG3xClpUNmo9Pxi5g9jOEkWWaaQhS1TLvLhOSI
	Mu1l4P0MWRQT8NbEk8PemlvxHmv+E4vDd4seMnc9FweBiRbgSxhcSUU9Zd9PVm3523HMIJnsJdm
	iiKh8PSziuseiRMvtXheHQAP48H23jCArNrx6mkWLTVyUdK5ugH1Xw+MV1g4VBBhL1WTtf5OUGD
	iKpcnTxMSqtCkoFoPhM//cOljylg7XhPzQVq8eLjC5AC6MtJbCu4xbMAGqlOHImXLF+NVWzTads
	d0lNuBz7ab0K4hCrf85GAoep5C80dTud+6HLPLQZp1JfGKSZzjNlJnDx+KFB8/5JeHNot3h4vep
	OuSURhRas=
X-Google-Smtp-Source: AGHT+IEm6uZM4RAeCABdnb/HiTLTODDlOSGLsclt+dZAzBWKW5inijJ7fOSsCspXZAm33MZDkPnqHA==
X-Received: by 2002:a17:907:96ab:b0:ae3:5e2a:493 with SMTP id a640c23a62f3a-af9401da701mr1424798966b.49.1754401786936;
        Tue, 05 Aug 2025 06:49:46 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af93ddf5b48sm635350466b.49.2025.08.05.06.49.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Aug 2025 06:49:46 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-61571192ba5so8062383a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 06:49:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUzYE47M409Vs+0XWWzZaIS6ry2koQChGfR1Tw8uU7GQTVnc2i875qhJZX6bkUY5BIirwnlpsXK2hG8PWc=@vger.kernel.org
X-Received: by 2002:a05:6402:5201:b0:615:eeb4:3a26 with SMTP id
 4fb4d7f45d1cf-615eeb43e5fmr10589970a12.17.1754401785931; Tue, 05 Aug 2025
 06:49:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250804162201.66d196ad.alex.williamson@redhat.com>
 <CAHk-=whhYRMS7Xc9k_JBdrGvp++JLmU0T2xXEgn046hWrj7q8Q@mail.gmail.com>
 <20250804185306.6b048e7c.alex.williamson@redhat.com> <0a2e8593-47c6-4a17-b7b0-d4cb718b8f88@redhat.com>
 <CAHk-=wiCYfNp4AJLBORU-c7ZyRBUp66W2-Et6cdQ4REx-GyQ_A@mail.gmail.com>
 <7f891077-39a2-4c0a-87ec-8ef1a244f7ad@redhat.com> <CAHk-=wgX3VMxQM7ohrPX5sHnxM2S9R1_C5PWNBAHYCb0H0CW8w@mail.gmail.com>
 <623c315b-b64a-4bb0-a5d6-e3a2011aa55a@redhat.com>
In-Reply-To: <623c315b-b64a-4bb0-a5d6-e3a2011aa55a@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 5 Aug 2025 16:49:29 +0300
X-Gmail-Original-Message-ID: <CAHk-=wiYLcax-5THGofwk-SAWYZ1RsP08b+rozXOm0wZRCE9UQ@mail.gmail.com>
X-Gm-Features: Ac12FXz3lI4E-j__TY4v_LJzzfEvCanQDsyxBrbM5v_ORnsVlB0ZNjSgcHSRh24
Message-ID: <CAHk-=wiYLcax-5THGofwk-SAWYZ1RsP08b+rozXOm0wZRCE9UQ@mail.gmail.com>
Subject: Re: [GIT PULL] VFIO updates for v6.17-rc1
To: David Hildenbrand <david@redhat.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"lizhe.67@bytedance.com" <lizhe.67@bytedance.com>, Jason Gunthorpe <jgg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 5 Aug 2025 at 16:37, David Hildenbrand <david@redhat.com> wrote:
>
> Ordinary buddy allocations cannot exceed a memory section, but hugetlb and
> dax can with gigantic folios ... :(

Just turn that code off. Nobody sane cares.

It sounds like people have bent over backwards to fix the insane case
instead of saying "that's insane, let's not support it".

And yes, "that's insane" is actually fairly recent. It's not that long
ago that we made SPARSEMEM_VMEMMAP the mandatory option on x86-64. So
it was all sane in a historical context, but it's not sane any more.

But now it *is* the mandatory option both on x86 and arm64, so I
really think it's time to get rid of pointless pain points.

(I think powerpc still makes it an option to do sparsemem without
vmemmap, but it *is* an option there too)

             Linus

