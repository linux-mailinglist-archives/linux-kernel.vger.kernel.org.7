Return-Path: <linux-kernel+bounces-848355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BCB54BCD847
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 16:26:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4F5034FF49F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 14:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E61D42F549F;
	Fri, 10 Oct 2025 14:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="UAd8pFbN"
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5892F291D
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 14:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760106283; cv=none; b=SOBr7Zn5se9j4AssoC8c77C2ASHEaDZe29b//iM0IcgyCvOvO+K3EiRKb3+msJSOXYhJ9j38Lu/LKVclVBD58NhIH8t6k+sz4VssdgGG8WSdJ8Km7QfF57PvJmQfUNLWi2Iq7kYZcrYAePwv6h1B+smse3JHdi4iJzWdhQLJGDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760106283; c=relaxed/simple;
	bh=FypwSt37vG1md4KKEG5AIsIq7ywXjB04LKNgH5d/XI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=klqaZACBtY+nT92Q8I9l6GM/UnkR+spkB+p7RVXywTMwrokvDHa3OabEXAPwPOlbpgXr+37xSbffUI05ciql/fhtfcg4qHQe9QYUUilg3uAuWmrRISUz3k9cVsK7aPBOSwJGXegK+WEpVG0Y195bmRoNNi7tmfdn88sPT0CeHBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=UAd8pFbN; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-796d68804a0so26215916d6.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 07:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1760106280; x=1760711080; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7iyPHKtQGvaoZRtoo396PCUKbJdnxgn+DD5EY6z9BQU=;
        b=UAd8pFbNzqcUPkAUkMwM514K9p9nDbMqhrbCEJ+vGqM+hPj+5R0PDChhBzftx9pRcc
         FJJUduVwx5kfpxeQcPzaJXFRgWbXLgR4QYmc9XIlNm5Q7xljAT9L/rIfKSHZNty5ZeS1
         SQsIwJLmbUvE6RjR2blsGbtdNGU3YmIHwyHOqr7AoVyNuHzg7em+wWZVyshY2e88k5sp
         CikrUbXr6ylM5oBp7heLylDXpm0I1NSXF/NtmNS490zaP9kh6H9JbApIWtrZJU5+rZvN
         5D7VPckp72hQ18ejwwzoAJ8x7Go1l+pX2FgmPeeYW62rEhf0LpOHkdK0oSZasYjZYARJ
         qMXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760106280; x=1760711080;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7iyPHKtQGvaoZRtoo396PCUKbJdnxgn+DD5EY6z9BQU=;
        b=sBc8DAjUYuTJ2DSr496LQDC11oTV/uByJwUZpWW/iBlGAedfmvmLSrhGyggI0zGXKu
         WhucvBG/9E9cDKW0JP/7dVtwkHy4Wv1uH03W5rqKkBRyKJ+QmAxVdSDL8jiqm+/Xlo7z
         12gjb8XlGlgBHkzE1+0MP9vmcsO33LgLhMdJV/otGGMApmtI6E3ZdtuZLUSAQFUb7qbs
         NXYoiPzkEci8jkRwMnTOPRr6l87vui52bnKL9ZazTub1FXoAM2o/7e+3s9f+GRfwE9Kr
         uvLUFRIDob9dWXsTo9iWs5D66YASSeJLsbwcTcgYZGOpEXKMLCQ31f3s03nhzp1I3ODM
         JrEg==
X-Forwarded-Encrypted: i=1; AJvYcCW8/BFkrrgEV8toRwoppEeL7GVb5X16RpytzQrIUot2hvR0fq5+NATMUwpLcF4oHdNEOpR6Z3Z9rLPZBpE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxy4B/bTY6lsC/ainjsjkkNDYRdKD1qyvZwR2Ry5CcnMcs83ihg
	necCG8NAHyVREoQ8AEBpNsdgenox1aa4kOfSIaQk4I83TQ5ynb5c1wTWWpbVVIeum7E=
X-Gm-Gg: ASbGncsKSs5JY3O8jYXFaQ/b8l5PFvgTBqCS3xToAlYONGoRoCDD1ZUp3hZlNS+gQNv
	H3EmqvYh3DqK0fZrki+l3Y+RO5AZ3Roylak5t63HVNIbo9kInMhvYWZvastR9lDjEf8yyl3Uigx
	LJzPdHuxyIksu4JyHlagJq4ljHFm+niz8/9RPnkhlzKwR60jG8aZw31ak+8Tz+XOHRqcS5MS2Z3
	EFmMPVjcnJauc1GcGcdbG6bXJlUAyW/wQ35Xqgrr0Gdbc9e9FtxolRhwzoRJA5DOSqMhAOY4SfU
	ksQVSMGTnHyp7mdttIwyf799uDzQTRDHHGGmyXowHyLcZZsUv/BReOH5LseD2/mGgQ/+ezTJ0gR
	ALQI/acMcx0tuoHh8O6BJEs1HLpPZ/ooVtItXHXIh6NFLxb8WthNXbjtJJRJzbSZKdPbNUR+u0t
	p9EJxZqUFN5JqND5+yDcY7BRLSw2P5Ll0K
X-Google-Smtp-Source: AGHT+IGGIljqRupcyKQ0pYTnR2I4bYgZq3r4A5q2oy3k8FchXGU/tlrboTSpOldoH1daTEMHuGVvTA==
X-Received: by 2002:a05:6214:491:b0:807:3dcd:bec5 with SMTP id 6a1803df08f44-87b2f0327e0mr148115976d6.61.1760106279689;
        Fri, 10 Oct 2025 07:24:39 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87bc345da73sm17323946d6.8.2025.10.10.07.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 07:24:38 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1v7E2w-0000000GVkh-1LAr;
	Fri, 10 Oct 2025 11:24:38 -0300
Date: Fri, 10 Oct 2025 11:24:38 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Samiullah Khawaja <skhawaja@google.com>,
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
Message-ID: <20251010142438.GD3833649@ziepe.ca>
References: <20250930135916.GN2695987@ziepe.ca>
 <CAAywjhRGrGjZK3jQptieVWmdzvjfNtTYrp2ChTZJSmFyrBaRqw@mail.gmail.com>
 <20250930210504.GU2695987@ziepe.ca>
 <CAAywjhRQONuHsxTGQZ5R=EJbOHUD+xOF_CYjkNRbUyCQkORwig@mail.gmail.com>
 <20251001114742.GV2695987@ziepe.ca>
 <CAAywjhRKvZBShj7KAXew2v_uGjn3HhvO=sFrZ=bVfMJ8ye-Vyw@mail.gmail.com>
 <20251002134112.GD3195829@ziepe.ca>
 <CAAywjhQrAWPjb8YtO=+G+pfJpW7p-rwrj03zB8ZqdhB0wtsO0w@mail.gmail.com>
 <20251002173715.GH3195829@ziepe.ca>
 <CA+CK2bC58SLTrROtBQaegzSfjU+bwH_3pjjWdd+JTnHqQPuAwg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+CK2bC58SLTrROtBQaegzSfjU+bwH_3pjjWdd+JTnHqQPuAwg@mail.gmail.com>

On Thu, Oct 09, 2025 at 09:28:44PM -0400, Pasha Tatashin wrote:
> On Thu, Oct 2, 2025 at 1:37 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > On Thu, Oct 02, 2025 at 10:03:05AM -0700, Samiullah Khawaja wrote:
> > > > I think the simplest thing is the domain exists forever until
> > > > userspace attaches an iommufd, takes ownership of it and frees it.
> > > > Nothing to do with finish.
> > >
> > > Hmm.. I think this is tricky. There needs to be a way to clean up and
> > > discard the old state if the userspace doesn't need it.
> >
> > Why?
> >
> > Isn't "userspace doesn't need it" some extermely weird unused corner
> > case?
> 
> It might be a corner case, but at cloud scale, even rare cases happen.
> For example, if four VMs are resumed and one crashes while retrieving
> half of its resources, we can't simply reboot the machine because of
> that. We must have a way to recover the machine to a normal state,
> even if some resources are not reclaimed. I would say that finish must
> be properly backward-ordered, but we still should release resources
> that are not reclaimed during finish, as well as those that were
> reclaimed but later closed.

Sure, but as I said, userspace should deal with most of this, and I
think we should lean into the worst error flows end up "leaking"
resources. They are not actually leaked, the luo still holds them and
userspace could still try again later to restore and free them. They
will get cleaned up on the next kexec, and kexec to recover from a
partially failed kexec is not an unreasonable plan...

This means think carefully about the userspace restore sequence so it
is more reliable. Like don't restore the memfd as the first thing :)

Only if there are real measurements that this is not sufficent would I
think about teaching the kernel to do a non-restore flow where it
directly destroys the object in a way that cannot fail. Eg the memfd
can directly free the page list instead of allocating an xarray. This
is alot more complex error path code to add to the kernel so lets not
do it without a strong justification.

You also can't do it until something sequences the vfio and iommufd
parts to unfreeze the memfd, this is very complicated error flows as
well.

Jason

