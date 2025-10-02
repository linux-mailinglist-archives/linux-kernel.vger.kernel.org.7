Return-Path: <linux-kernel+bounces-840578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A51ABB4B51
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 19:37:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 540852A5D4F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 17:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F10C27146D;
	Thu,  2 Oct 2025 17:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="dZTwTz9m"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9131D4501A
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 17:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759426640; cv=none; b=VizMI79kiyA8lqAtFv/TcdPbcUddl/qtcbYguTMLySznavscSKYU9ppBktzdbB3fmCHL+r3nelmdSkEmKzyOC7lidEPK6HwPEUB4TDum1Zgv6psgXRDAPAWjsYSqz9j6nYcW+WZdRXe3k8NETkRHysPcCf33/v70B/K+2yr7WMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759426640; c=relaxed/simple;
	bh=zfljy4Rm2gxAbHAU4BzNBsIV17zBOVvWrtlgKwNOXgI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u7gHskor8QT/K8F8vVQQr7k2rhTZwTnJ7+wu4HDKPmXPxI5LZmqGqugoAA72k5BQT0Fl5vKl2HDi72oXLd93qAX1TdoXH5lxuaUOeKdfpCI5oOKzFYblq+CgBBCN3AOFbI6GV9foxjltllgkWA3LFL0lhQ3Az0jRdRWqPZ71B/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=dZTwTz9m; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4df2911ac5aso8132031cf.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 10:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1759426637; x=1760031437; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=usaTapTx1sgKpFrU7r+u4hDXdRvsxq3M0Se42L8y/9c=;
        b=dZTwTz9m4r7I8ld3PRIvmVkhrqBNpXuPG0XLZvhzsFsTEkCVkOi+ljUnSfuL+s1cH3
         c5W6y3u3kRbhtMZEjIrRcBHjzLVuFyiybVe/3KjpXtA1UEL/8h2cyG/dBEodb9U8v0rJ
         AoWcShqkiJRLnF8d49zS8/Xcq9lAW6rZRuvg4T+XvFHH4m9DASq+kPCb5T8o6rBXEBBy
         vCQTHkupSwKlW5iUa8OkmfEOF7mjSEeVStxzPvUSQ7nqbXCDmuQ0bE0kTUafanapxZn8
         s8vQHh1/4FnM3olzqDJ4H54fXCtw9v8m/9Ti0eZHcvDKXBdtM8E+9YHThWDtC7xW1J2/
         y8/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759426637; x=1760031437;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=usaTapTx1sgKpFrU7r+u4hDXdRvsxq3M0Se42L8y/9c=;
        b=dyK8moLkwuK9vCQA8+TEpyiZVoEGLfGQeh0QBQLyapv1sO851fN6Kv9+z2bLHYYU7W
         VA8HXb7O8duZ/KZQ8t7g4EPuTeoCx6A5KGiiEg1p0nSjDTSBdZe48/AVpoBlSXviPBuY
         GchqOhC1V+4xRxCkZM/7iiHattmLCqmqi9+wapA71BTAIin7hascnAI1csaLdyzEcb6v
         eYsjfSOJ9YQfXI/cY5iT4QoFXC1jWtEtx69+i/c4W3lYOnZs3xICkBrBP2YQcDRx8Y7l
         e2v/Ww1lbTzOa7zhtyVjWRJvt5NK6XI6oZUV+Q6v3RbU3okKRj6zL2iTApHf4QG/5Ie4
         gJgw==
X-Forwarded-Encrypted: i=1; AJvYcCVCzDrOJBfJ+zetOf+hyFYKlC9GI145QEzvxYtXeyubTecwJjISLlSTRcenM0Dd6+v6pUpLlVTK47/oinQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqCT4PunQzaAsA/4XeX8nrIy+6YtUrj2S7dnGNWkDon2zJEMKH
	1/nmO9+PO1UrY6GH7IBt60csiJXcBl7JoTxWZVB+E/MCCQuNawVxgXry4AaIL7hoYWY=
X-Gm-Gg: ASbGncsayfCFR2IPAhAUAXPszKW0hJA5RmJBFV6NaJwaD6RzIw8fWaIBRMrpyroQffr
	7+NyEECPsC1jnqR8nKdXIuZOQc55+yE5kE/1DmAFya3HA+xK/QsQaDkeNA/5JvY3GkOvzSRF1TV
	veZ6ekX7xtPlt6qs5jBVOqszYSJoDh5Jf/eP0o1QDUKvm0B+quxDfk4Cba4kZijngGiAfoQDZ27
	Yh9uFCMErefR4dwHKPbIIByy4DAffExw24XT1mFTGPhwOUTLm39tLcjX40ewt+joWDRmND+WgXQ
	uRBF5TfazUEHaywY/6VDoVWlVl93RCJfcvEoylbGLdOXdmzJKq1n1kKFOvBgSh6sEoUYYe4O3q3
	6KLzpllI9yYZUJkX/kQvLaR3q7RHxzAjOAXEzGh5Kj5DktGFHUUWd54UVtEqIl6qGew21WhtVMz
	akucei9hD6pF9r0Ta9
X-Google-Smtp-Source: AGHT+IGqv29Dy0T8wGzWH5+5dxVX2ZhsX0Xz1O+fH669dX+huNL5ezHyqYOUT+Lon2w+sCCyknNBWA==
X-Received: by 2002:a05:622a:2616:b0:4e4:6b32:697a with SMTP id d75a77b69052e-4e576a7c166mr1990251cf.29.1759426637208;
        Thu, 02 Oct 2025 10:37:17 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4e55d0cb42dsm24306201cf.39.2025.10.02.10.37.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 10:37:16 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1v4NEx-0000000Dr5o-3d9u;
	Thu, 02 Oct 2025 14:37:15 -0300
Date: Thu, 2 Oct 2025 14:37:15 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, iommu@lists.linux.dev,
	YiFei Zhu <zhuyifei@google.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Kevin Tian <kevin.tian@intel.com>, linux-kernel@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>,
	Vipin Sharma <vipinsh@google.com>, dmatlack@google.com,
	Chris Li <chrisl@kernel.org>, praan@google.com
Subject: Re: [RFC PATCH 13/15] iommufd: Persist iommu domains for live update
Message-ID: <20251002173715.GH3195829@ziepe.ca>
References: <20250929160034.GG2695987@ziepe.ca>
 <CA+CK2bDqDz3k0gXamJEbKUL7RPBLVjaA5=Jum=CF84wR+50izA@mail.gmail.com>
 <20250930135916.GN2695987@ziepe.ca>
 <CAAywjhRGrGjZK3jQptieVWmdzvjfNtTYrp2ChTZJSmFyrBaRqw@mail.gmail.com>
 <20250930210504.GU2695987@ziepe.ca>
 <CAAywjhRQONuHsxTGQZ5R=EJbOHUD+xOF_CYjkNRbUyCQkORwig@mail.gmail.com>
 <20251001114742.GV2695987@ziepe.ca>
 <CAAywjhRKvZBShj7KAXew2v_uGjn3HhvO=sFrZ=bVfMJ8ye-Vyw@mail.gmail.com>
 <20251002134112.GD3195829@ziepe.ca>
 <CAAywjhQrAWPjb8YtO=+G+pfJpW7p-rwrj03zB8ZqdhB0wtsO0w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAywjhQrAWPjb8YtO=+G+pfJpW7p-rwrj03zB8ZqdhB0wtsO0w@mail.gmail.com>

On Thu, Oct 02, 2025 at 10:03:05AM -0700, Samiullah Khawaja wrote:
> > I think the simplest thing is the domain exists forever until
> > userspace attaches an iommufd, takes ownership of it and frees it.
> > Nothing to do with finish.
> 
> Hmm.. I think this is tricky. There needs to be a way to clean up and
> discard the old state if the userspace doesn't need it.

Why?

Isn't "userspace doesn't need it" some extermely weird unused corner
case?

This should not be automatic or divorced from userspace, if the
operator would like to switch something out of LUO then they should
have userspace that co-ordinates this. Receive the iommufd, close it,
install a normal kernel driver.

Why make special code in the kernel to sequence this automatically?

> session manager (VMM or LUOD) decides that the finish needs to happen
> and the iommufd (or the underlying HWPTs) are not restored, it means
> that LUOD has decided that the VM is not going to come up and the
> preserved state and resources (domain, device, memory) need to be
> freed/released. 

I've been assuming if luo fails so catastrophically the whole node
would reboot to recover.

Is there really a case where you might say a kexec happens and a
single VM out of many doesn't survive? Seems weird..

So to repeat above, if this is something people want then the
userspace should complete luo restoring the failed vm and then turn
around and free up all the resources. Why should the kernel
automatically do the same operations?

Maybe userspace needs some contingency flow where there is a dedicated
reaper program for a luo session. The VMM crashes during restore, OK,
we pass the luo FD to a reaper and it cleans up the objects in the
session and closes it.

> > Maybe the HWPT has to be auto-created inside the iommufd as soon as it
> > is attached. The "restore" ioctl would just return back the ID of this
> > already created HWPT.
> 
> Once we return the ID, do we make this HWPT mutable? Or is this
> re-created HWPT just a handle to keep the domain ownership?

That's a bigger question..

For starting I was imagining that the restored iommu_domain was
immutable, eg it does not have map and unmap operations. It never
becomes mutable.

As I outlined this special luo immutable domain is then attached
during early boot, which sould be a NOP, and gets turned into a HWPT
during iommufd restoration. The only thing userspace should be able to
do with that HWPT handle is destroy it after replacing it.

Jason

