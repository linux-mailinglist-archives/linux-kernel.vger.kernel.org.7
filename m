Return-Path: <linux-kernel+bounces-859481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F14BEDC7B
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 00:36:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7463189F6F9
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 22:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6412D28C006;
	Sat, 18 Oct 2025 22:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ctgfptj2"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE423BB5A
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 22:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760826987; cv=none; b=Xke1PbDWBYYyFg7DtuvafUmwguQIu6HL0hNPOg3sZGirfEaZVH0XgWzsFpb2k19HhkyWy8z27rA8jVftZZjM1i4vO6U1NFmB1cxzjJfj9+QueN1860SgL7uo6c0T9OomuKbYfg4bHK+EuD1+d5xjltfUlni7glEjdwchzW7xYQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760826987; c=relaxed/simple;
	bh=pFzf8miSsTyQTIElNQFz1n/HWqUsOyygD14DQhBgn9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=COCAbQQ0mNb0n54tH4PHbyBcvAjCTJ27vQkFgD0P2qpmEmMm4oRNgNYfEV47dtjZP+Hpqd4KAEorWUWeqmXt2/jU7uj7NjHT8ExvxfmmTW5giBNuo4wCsgYOngMZFG19TWtnoSGtDd6hxD0YaAaGQ2AP597r8byd1++z//AnbZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ctgfptj2; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-27eeafd4882so147055ad.0
        for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 15:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760826986; x=1761431786; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fGbB1TR8d5jbyTjinpqncT8Bz5A4q4YggszjBvUfqm8=;
        b=ctgfptj2K5SeM0ChPgRJi1Q8eEHiR+oTqgerFPQvFat900Rj7RLj0J+Af1LcrI9Ecw
         RfccPIlwdbChDQ2vqQKcKGKrQsb22XJxl+SgPK97g0DM46uWMq2zRSQpZrEZT3jEfear
         dSk1QRlq0HsxYCZR7HxLtABc1ZbtfTJ3NsaFlJI148FkiqKbFq+6gcDNX/DWs6pZRFe9
         sxkBrf+AN+Q5BfeFK/jyw7fzsuhwO/J53ygS7iCPDUaSlXCM07QncHUD59ekLuD4q6aU
         tuc+BRQN1LuCBHfel5VofhsJ2vpgRZ+hWh5aIt606RxkzYR9g/wSdICtkJzGCktegTCT
         oKqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760826986; x=1761431786;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fGbB1TR8d5jbyTjinpqncT8Bz5A4q4YggszjBvUfqm8=;
        b=N/tBr0gwJkpT9HJV6N1+PyLVlhaTMSC2Ai2mVn/cIwYgHM/mJNa7h8fIjEF3XVQsah
         frW8NZQeZClu/GGOr/toH1h2dtKVbtjjGHtIuG8Vl+cb6MWIgY8nqLEAz4oOkbjvT6gX
         Wyn0EosRldoS/55MHanyuvYL0FDZiAGidcqTgz+qLtHflO2r8V5ld1hb0Y0/fmECSs/b
         vmCoyy36QWTZ5zgOzwb2URFppQUwxSJlSg0qemBjl97S66zRT0fgymSyq3eKYeSYXYH9
         zff2o64bVSUYujnkPNcu7gPQAvLsynmabpJYfviVBdhoC22BBZyLozBJDlUkbdzRTVI4
         PPXw==
X-Forwarded-Encrypted: i=1; AJvYcCWqdJZw6AL1CJ/aXQEnADnyOKfMWkkxKY4dSyPtd7kM7O9eBGpFAU81yDCA6xLlF8OKbWEGsdoewDfKdlo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfNRjHkYHmNJ6OKB1kt4yTP9kKz6nJ1gIMMItLUid09MNhi7Hj
	sGRNviU9SEjCICsW0H1xD8CowUsz4pDeLOFGYkgGUz3sL+/Efd6FAVRRS7Dm5+aZhA==
X-Gm-Gg: ASbGncuNmvNo13VwDwL2rziIuTJ/yzYp8jVCyJrTLOBb+PZdx1juo7IJHGuggr6/IcG
	K7a6c8q0Np6E/KAkHC9GHt6ptwHi5BMiz0CsukteJdKmrXBYU+T4OeCaiamx5tddcTkANMBTdEd
	ujGIiI/Vd59q6K6jhkGhemYp/LbiD3IDljYmYV9Yyro7qpXY28Ueb2trKIAS0abPrnW+axfW3fY
	Ng39CAplTUn1n/1YablSyqRGLbD1X+Jr8g3L9iShShW5K55kDpQC9rHDFgObeWL8zTnoheryQ4g
	I6rAV6lemQ1cDefU7Vj8nBD8hbDTmMnVddvQRbOEYTxpSgr8r4VHTCsK7cOSbsmrZnYBExRdG2/
	dJJuIrsSAcIRgrmsaW8k/SqdAf+XsebecObL/UQGfSybS99H5WBKKR7vYk3PCgnZQS3Lku5ccyc
	G2t5nPUfAVCjnWyoCrVZDWnbcVb/Lab79kzw==
X-Google-Smtp-Source: AGHT+IHaiRv9OLO9og6yUxkxhsxdkCBLs5Wc2YKRG+MPA/1ymOP45cWtQ/+Vc19xN84Mx5WD/38NbQ==
X-Received: by 2002:a17:902:c94c:b0:292:4d93:b501 with SMTP id d9443c01a7336-2924d93b64emr1647705ad.11.1760826985060;
        Sat, 18 Oct 2025 15:36:25 -0700 (PDT)
Received: from google.com (60.89.247.35.bc.googleusercontent.com. [35.247.89.60])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33d5de3295dsm3585285a91.15.2025.10.18.15.36.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 15:36:24 -0700 (PDT)
Date: Sat, 18 Oct 2025 15:36:20 -0700
From: Vipin Sharma <vipinsh@google.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: bhelgaas@google.com, alex.williamson@redhat.com,
	pasha.tatashin@soleen.com, dmatlack@google.com, jgg@ziepe.ca,
	graf@amazon.com, pratyush@kernel.org, gregkh@linuxfoundation.org,
	chrisl@kernel.org, rppt@kernel.org, skhawaja@google.com,
	parav@nvidia.com, saeedm@nvidia.com, kevin.tian@intel.com,
	jrhilke@google.com, david@redhat.com, jgowans@amazon.com,
	dwmw2@infradead.org, epetron@amazon.de, junaids@google.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH 15/21] PCI: Make PCI saved state and capability
 structs public
Message-ID: <20251018223620.GD1034710.vipinsh@google.com>
References: <20251018000713.677779-1-vipinsh@google.com>
 <20251018000713.677779-16-vipinsh@google.com>
 <aPM_DUyyH1KaOerU@wunner.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPM_DUyyH1KaOerU@wunner.de>

On 2025-10-18 09:17:33, Lukas Wunner wrote:
> On Fri, Oct 17, 2025 at 05:07:07PM -0700, Vipin Sharma wrote:
> > Move struct pci_saved_state{} and struct pci_cap_saved_data{} to
> > linux/pci.h so that they are available to code outside of the PCI core.
> > 
> > These structs will be used in subsequent commits to serialize and
> > deserialize PCI state across Live Update.
> 
> That's not sufficient as a justification to make these public in my view.
> 
> There are already pci_store_saved_state() and pci_load_saved_state()
> helpers to serialize PCI state.  Why do you need anything more?
> (Honest question.)
> 

In LUO ecosystem, currently,  we do not have a solid solution to do
proper serialization/deserialization of structs along with versioning
between different kernel versions. This work is still being discussed.

Here, I created separate structs (exactly same as the original one) to
have little bit control on what gets saved in serialized state and
correctly gets deserialized after kexec.

For example, if I am using existing structs and not creating my own
structs then I cannot just do a blind memcpy() between whole of the PCI state
prior to kexec to PCI state after the kexec. In the new kernel
layout might have changed like addition or removal of a field.

Having __packed in my version of struct, I can build validation like
hardcoded offset of members. I can add version number (not added in this
series) for checking compatbility in the struct for serialization and
deserialization. Overall, it is providing some freedom to how to pass
data to next kernel without changing or modifying the PCI state structs.


