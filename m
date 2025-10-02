Return-Path: <linux-kernel+bounces-840870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A58BB5A0C
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 01:42:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EDA04810B0
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 23:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69A622C030E;
	Thu,  2 Oct 2025 23:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f5LjvHRQ"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E442BFC8F
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 23:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759448568; cv=none; b=ReAYAfSeDvNFIUbHBlScvlMRBn0OKFtS0Xt+0WmUOfM3heiImvcp8i4/FhZXG3IG83+cKiP1rEG0/k++U9yPX4c1NnQiWNE2l/ECuJsK9Mih1GfpQD0F5ubPYXhNC3wV4WPjYaRELF5NRfg5qUuZ2zUhM/IkTLOf6rAjwaMrJdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759448568; c=relaxed/simple;
	bh=gJjbvYewm3FTigD0IImKi1Lk/ATATeELfBSgVimlQSI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XI9HA6vj0GpFB19rlzs2in2BOXxoOS0j4RHP+HHTdQcD6T1TxA+c9n2T/JHkPxbOqIwefVjtQGsjJvMNXUfnEVnUoxP8eAb9j4aRit0L2aV0DzvrwByJ+Du02p1prqNKl0Iim4Tixe21hIfU/wG7QzY75+AvsxB14obJzoLUSsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f5LjvHRQ; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-36527ac0750so15398361fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 16:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759448565; x=1760053365; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gJjbvYewm3FTigD0IImKi1Lk/ATATeELfBSgVimlQSI=;
        b=f5LjvHRQotQl+77GppalK+NyD3GAHZPeusJyRA5cQuy8BMlOTotdmPcwlSW5i+MhOt
         4QgQwVy6ns3v8ziYbDOHcULLRVBr8noSeXubvfjJf3TliSFXNRGZTUIlguq89EE2Psv7
         JewIed/gHhArhtPJsPTiipgUUeNbcXvAnLHMnSrOzBC5zGN4hMHqX3oSQ/ns8e+dQF25
         hfXbLas4dwBcvSt5iswiGdJee5qWOHYo3kLKPl/sYloK3R62gpqXFv+q2mi+9+uDO0jo
         1JnM5aeEaHd3FZ0S2EORso2a8DFpsbYxYoWhZ1WxHow2tjwT1wddMjJCYqhu5sa96zuy
         gH+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759448565; x=1760053365;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gJjbvYewm3FTigD0IImKi1Lk/ATATeELfBSgVimlQSI=;
        b=HLTHRb8lWJVBmIcBQ038U+DMZU/JhaUhUGUYNnCg6HFQx6h5BfS73cyBv8c44tiRL/
         RIxXXtQ0RYvhtL9pVmrg3Vdr9Rf1SkHW1A7eq5yT9iYX4RV2cnuvhpVEsmKSYO1ydgOY
         pp1ku9vbLppgulUVuwnoWB5KnBVUUZ9iufIdNmw0U8BelfG3GtYxwuN4SwjW7uG/Khwf
         9WRs9oYYtruCD12vGwmriiwI4P+7UdrH20Qr5nVWlfyRrYNsWN6295P+RdtkqdmDm/y2
         jczktHM68r+YSeOijf2pZgDY6IxnOka95EJGWl+SKO/d8TRKFMLoJ5l5B5YtZJd0qdIL
         PJ8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVlpc0McURjGlCoB1Hu125aUHb+n4JQcqYbnzeQljP/joj/UXeoVomabMKYXOkkK7BUnMddxCmeoug0nm4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywddxnjno9MmCoRzMkzhbGSsO1Eg9Yc5k5lX1hGeldrALcWDPoT
	eC5WsthCO7duN1xgHy8W9wBjYTsOGKHPvNF0FXaebSZSY8gzfLmzcV8BEAFo14ICRmSFkqjp1/k
	wdEP/G/02XpQe/MLaNhbfTMjSxUM54XX+vwAJxEJ0
X-Gm-Gg: ASbGncsHC6eH3DoYkNnIW6c72bGyG40u2Cn3EuTMh67Qrrh4jhJZBoAsHNNwk4rXrjT
	oPBMrecjZpD+hR5QVygZOLrZvIaxpZhv6G8eKtC4ftbDQrpSHSL9sLJyTZux8mBgUOGzNldbqPh
	PM0CIroa4RAUMSSY00M7r2w1+1cxtXedLi8KYlwhjEPljDDTmnW7HHhJqrivQx8o7OOD+VJbj0N
	D7TPzye9uMEfg4Yb7ZRXEYnWTbWGc3cozgDEg==
X-Google-Smtp-Source: AGHT+IFZ1jB2tcB8G2J26ZHxSJC11SyLjkju2JvcqrxYVc6SMqqMcsiXwmwlMmW41AI7IKEGdEauVtUZQAHZX9zl4fs=
X-Received: by 2002:a05:651c:50c:b0:360:c716:2666 with SMTP id
 38308e7fff4ca-374c3849b72mr2777821fa.30.1759448564630; Thu, 02 Oct 2025
 16:42:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916-luo-pci-v2-0-c494053c3c08@kernel.org>
 <20250916-luo-pci-v2-3-c494053c3c08@kernel.org> <20250929174831.GJ2695987@ziepe.ca>
 <CAF8kJuNZPYxf2LYTPYVzho_NM-Rtp8i+pP3bFTwkM_h3v=LwbQ@mail.gmail.com>
 <20250930163837.GQ2695987@ziepe.ca> <aN7KUNGoHrFHzagu@google.com>
 <CACePvbX6GfThDnwLdOUsdQ_54eqF3Ff=4hrGhDJ0Ba00-Q1qBw@mail.gmail.com>
 <CALzav=cKoG4QLp6YtqMLc9S_qP6v9SpEt5XVOmJN8WVYLxRmRw@mail.gmail.com> <20251002232153.GK3195829@ziepe.ca>
In-Reply-To: <20251002232153.GK3195829@ziepe.ca>
From: David Matlack <dmatlack@google.com>
Date: Thu, 2 Oct 2025 16:42:17 -0700
X-Gm-Features: AS18NWDaj8RvZipjEJ2QAatnJ0ODM4jInJmPqpdDhTEeGpvwrsDlFmhWeb1pz7I
Message-ID: <CALzav=cYBmn_t1w2jHicSbnX57whJYD9Cu84KJekL0n2gZxfmw@mail.gmail.com>
Subject: Re: [PATCH v2 03/10] PCI/LUO: Forward prepare()/freeze()/cancel()
 callbacks to driver
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Chris Li <chrisl@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Len Brown <lenb@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, 
	Pasha Tatashin <tatashin@google.com>, Jason Miu <jasonmiu@google.com>, 
	Vipin Sharma <vipinsh@google.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Parav Pandit <parav@nvidia.com>, William Tu <witu@nvidia.com>, 
	Mike Rapoport <rppt@kernel.org>, Leon Romanovsky <leon@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 2, 2025 at 4:21=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> wrote=
:
> On Thu, Oct 02, 2025 at 02:31:08PM -0700, David Matlack wrote:
> > And we don't care about PF drivers until we get to
> > supporting SR-IOV. So the driver callbacks all seem unnecessary at
> > this point.
>
> I guess we will see, but I'm hoping we can get quite far using
> vfio-pci as the SRIOV PF driver and don't need to try to get a big PF
> in-kernel driver entangled in this.

So far we have had to support vfio-pci, pci-pf-stub, and idpf as PF
drivers, and nvme looks like it's coming soon :(

