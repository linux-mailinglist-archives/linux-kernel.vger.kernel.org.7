Return-Path: <linux-kernel+bounces-878923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C1C6C21C5E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 19:31:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 641483AB44B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 18:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F9992D8779;
	Thu, 30 Oct 2025 18:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Gg+iYOhC"
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA74B25C818
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 18:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761849084; cv=none; b=s8DgHjSvDXesWR3g95R7TwnI4wsPFYqGVgoMdkwQQ5Kve/uOo8f5b09n29IFBkAJxAiU5D2kjQ+18iFzeDmzNQ0u1PsWURfwipTvaA7YnQEchV+E695CO8WDX7BatxEu6tzCDWJ7PWpOv3F/zzTam1JtKsdWHKSma1ilbmZRb64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761849084; c=relaxed/simple;
	bh=5RKHu4yQCVaI/k4lkpmrIBeROuwDpbJHr1wtuuLkbUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=poEfXuQXzNgxucdHYVllkmoTNQ5+Td9OgG0+2ftYDcSclDWG3JFhEfGhNwV9mDTuc+iYhruzEg+Cu4EprVagZIw8fJHC+XS0GjQDpAUxgZFHA44pdDj731r62b+ibapXnupv1UgjVVcdZE83WlTpXWmGM5HSL641JbMpsHfQpt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Gg+iYOhC; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-880255e7e4aso7111066d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 11:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1761849082; x=1762453882; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YmA1pUSO6eHGo1pfWERtEyAsYO8fk0tMGzPgA1+3ITg=;
        b=Gg+iYOhC9eUE5OHVWT2jzQGdPwe2d0AkOCKhtGaWmf+O07sKhJqUCLh36ZezJMOSAw
         PufBmBzphhM2wk1lokMLIh42oPg5Fk5m7jZFqN9SwurEW30OYcZhhocqmvRQmG54pDuG
         6nA9evXwOi0kE2p9zpqqQIL5zhflUCUnOk67IrcYTk5f3/QXy3acsm46kFjhXkgsvKWW
         E+jC1AmqYPXspcktAP4A3djApFlzq8JhkCrt9KFv9kPsn4B2Nx+CPCHWRqaQ0KTU1OV3
         o5eWp2h5poS7waJtpfEOJJ7416dR3d5eN5ZpEbrRzPTLp5dDC4O+5hxdqqutsSQwY8i8
         TyQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761849082; x=1762453882;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YmA1pUSO6eHGo1pfWERtEyAsYO8fk0tMGzPgA1+3ITg=;
        b=WPpRfPo2eXUctkLeBD8gQBR184bkcd9Jj7s6u4RmKGjSIl/1dSDLhLrUzyP6LNNiyw
         /AbahouvhDaMCPkgfWkmOlaTLm+vet9P2mFfCLmnNS4RAPmsDZgAZmkkJsrf0seogkww
         oereYBc4wUZzpq060OyoiNu9VNrK/ULSDsuuTHSoh7p8wnS22z3GgnWHtFZAJq9yki2b
         maAKzQG/lFx3VFt6XUy08Ryb6xMiTPyurTVkvXFbb3QVOGnvAzumJmslbVeMmm+asMM5
         NragUVQlX05YBqwMPaRk5N/M92u3RTHhYau7hME9xZOcAcbI13Anp50FEglM3oFitJ2S
         eGjw==
X-Forwarded-Encrypted: i=1; AJvYcCVTKGzRpfp002H/8xxevY+iBxGA/mRHLfCwRdJUx3w5pYHcIb0f0EAZLzJIQGRnE5aUnHDxYJJUSL6PXyc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5k8gW2pAIPxDxHcd3MGoTuYRujMvLHlKjrTmbB4wJezoLud3x
	EUj0oxK/1sk6qezg0qTWR1ocnXpWJDxUTx3yKbIR3lfM/K7i1Xw82ryt3Yjf9ojQf+I=
X-Gm-Gg: ASbGnct68FSigdfJOWco8KkHQ7UrOQXO/loIKQ6v5Y7UQCXXyF0Ee7Q1onE7hMHemBx
	QS4G2/3+iJ/K2sG1W0AqDXnuNCNlONDgtdGfMvifjP8X0AyJ1ZeXVBy/MJfPOyVL7kTkrhNI2B9
	eGNOOvmeCIGOHfIuZjPssEXBYt1O5sIui1N3eyFRK/savKR9Ast2gLC0sbrKJzjuUJGSn/UIONV
	dQs4fsbdQcQzSWpyl6RI4WwL0Hzy4cG4NkgFgZiacIjD1a4ZpNrKc6h9BPz968pUsrTwbQn8US8
	psdX2JNoXSdLP5E6ciyu2m+QsC4EC81Hhu77hsQlTyuEBYTWTdJGMOcMR0AL9kzJZlRDqF2Ye43
	cngClWzHFjGswo0z4KSJeqkLI6ky6LATp5hn4cMkmMwQPJwpnED0x46z+oh/zb87lTBAipm1jDy
	Jh4JVnqbXi/GnnCkswG1kOkvs6x4u93yKFvy/IKG8ts7hxbQ==
X-Google-Smtp-Source: AGHT+IEv5ox+SBer5dHqatVl1R0h0YMhFs6NlP0L5tS5SfBtQ01+uSnat7aVp139Vftpn89RlMT38w==
X-Received: by 2002:a05:6214:dc4:b0:70d:6de2:1b2e with SMTP id 6a1803df08f44-8802f50545bmr7765036d6.58.1761849081478;
        Thu, 30 Oct 2025 11:31:21 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87fc48f6138sm123307286d6.28.2025.10.30.11.31.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 11:31:20 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vEXQe-00000005BP1-0lfY;
	Thu, 30 Oct 2025 15:31:20 -0300
Date: Thu, 30 Oct 2025 15:31:20 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Raghavendra Rao Ananta <rananta@google.com>
Cc: Alex Williamson <alex.williamson@redhat.com>,
	David Matlack <dmatlack@google.com>,
	Josh Hilke <jrhilke@google.com>, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vfio: Fix ksize arg while copying user struct in
 vfio_df_ioctl_bind_iommufd()
Message-ID: <20251030183120.GD1204670@ziepe.ca>
References: <20251030171238.1674493-1-rananta@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251030171238.1674493-1-rananta@google.com>

On Thu, Oct 30, 2025 at 05:12:38PM +0000, Raghavendra Rao Ananta wrote:
> For the cases where user includes a non-zero value in 'token_uuid_ptr'
> field of 'struct vfio_device_bind_iommufd', the copy_struct_from_user()
> in vfio_df_ioctl_bind_iommufd() fails with -E2BIG. For the 'minsz' passed,
> copy_struct_from_user() expects the newly introduced field to be zero-ed,
> which would be incorrect in this case.
> 
> Fix this by passing the actual size of the kernel struct. If working
> with a newer userspace, copy_struct_from_user() would copy the
> 'token_uuid_ptr' field, and if working with an old userspace, it would
> zero out this field, thus still retaining backward compatibility.
> 
> Fixes: 86624ba3b522 ("vfio/pci: Do vf_token checks for VFIO_DEVICE_BIND_IOMMUFD")
> Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
> ---
>  drivers/vfio/device_cdev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Cc: stable@vger.kernel.org
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Though I feel this was copied from some other spot in vfio so I wonder
if we have a larger set of things that are a little off..

Jason

