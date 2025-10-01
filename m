Return-Path: <linux-kernel+bounces-839430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E52BBB1992
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 21:29:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F21D8192841E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 19:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 689452D7DF8;
	Wed,  1 Oct 2025 19:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="Br0NpJ0t"
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424722D6E6F
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 19:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759346976; cv=none; b=brrsoqNwfYECsF/xvopHhIW1hanHWkPNxSyB6F3G+Zx3HLXptlngZUSur6vFEvYdq+Pro0fNwUAS7cdlOD4x20VH2hj+owwKV0paDvHpDHCGn/HZIaZvXtyDj3Gi0Kr5kZfryisp0zmoG5jr7nzPyLbrBf8qmgkJSXwPBu/MvmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759346976; c=relaxed/simple;
	bh=DiDU5kDNSMZr+Mxe770JushwLa5d5oXzQtjmkdtoPJ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WptOBMYoKNkuQzpv3ddegGI8YBLUj/754Iua3SdG/t6Bzhmw9uRpke5mM37wiclJIBYIVri208EQb7B0WjV/Xc+QmKa9ui3k3v4u+cRue4RE8+G2Dm7ByC/oQ8Nr9xZ0ICuiCpHQWEmTqGJoVnQ/keI16So7ju+jIOSkzEdPFSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=Br0NpJ0t; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-85cee530df9so26981785a.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 12:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1759346974; x=1759951774; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DiDU5kDNSMZr+Mxe770JushwLa5d5oXzQtjmkdtoPJ0=;
        b=Br0NpJ0tmp2VOWUOfxgvB8E4PmPbzGUocJw7tpDT+HLd5RF08eTCiziXQzIB+k0hWL
         Rlx5yImJ8Fc3xEiS1AS8G1z6ZlpUhEfq1URZWGcVfcT5UqL/DsU17gCcSXEQdoej+ou+
         X+chkB15ue9lmimyMIf6Zh13pXaOyL0fghwMcwy/IdYhzClimLKLF3C1ikYEIZb5xsq3
         6Q8mQRRZEwVBixxVGBsiOMlVsYsa/aq9wtSS1TRYNBBOoKE67PmGq2FtbldTVCWlQzjJ
         K2P8g1QQ5vgzl6C4TXxemD/NxtqSfcVafvJvAb3HZMlPpvmbLJIYk7K9ZMG0H3mZ6LQ5
         q2+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759346974; x=1759951774;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DiDU5kDNSMZr+Mxe770JushwLa5d5oXzQtjmkdtoPJ0=;
        b=RBb5M1ycYMFfcQAMl8s7NKjpVTAPIarcfA1DzTi16EIPCmg8lMnPNwd/TLZQLvSuzM
         hjCAX3Ygu5mZrnZGfE77hu8AdH3ZWYXOz+9xAjDQNSH/afoeMBJQY3sEhCHRjkTNEyqQ
         cuP1vNwsU9dhamcyFM2ww+CaiJ1DBTFll15TSSHQllGauzPL/Crkt/MCdbW+RkyoRIpW
         vHihnej3Eh8umELTnCLHm42jv6CQnpf25tp2EcnLgEWuhjihaINFad981IT1jl38i4Qo
         npxDQQ3QquXZ9X0+BHrPUQs+8nJ+I7vgXuJ/F43t3npakiT3mC55O9fD+SpmUkkf25K9
         JMSQ==
X-Forwarded-Encrypted: i=1; AJvYcCXyY5hdt6DGdJfd9CxGIv/bcO8Cf3L3NHnjmc+/xJUmE8aIBldr1kc+D7bgvdoYOEB+iaLCROqRUi2mgGE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZIu33uHcJSoBhQzK3CQM6/BulaUE05yGfI8/4+sPpTmPPi5l4
	9W3jy2icP5xb39S1xl0Dn7pC/6HQShrZRCT0o92g5Zcn8MNKoyiyYZGFI/FmIl13I52fqzXlUXc
	Z7vVdR7ATlSVjpz591kuHxCN6wOEFw79RMpfDBPAymw==
X-Gm-Gg: ASbGnct0yoC2Fb673u8831vZ0AzujtnqfUsYcnKaTzpRUc7t2fDLeWigeF2EG0QLoiB
	3vrW5CXAVQ4LfJ2/JdGgrsqYkDT34lEcgVe6afRk6SfFBmZwQ7QG3OsVd+bDzhyZdy/3VaYALOY
	mqo+sAeM+gYDUIojt7YWOhQ+vr8IGa5njiMhX50WH9Tb5S7xU4rbHwf0FPjyDch8YoEg52C+agw
	+/AcrjKxqzv3qsOngk4Fxl6q05GTKiT4GnDdHA=
X-Google-Smtp-Source: AGHT+IHLfUtJRDbSEiqp3HI8RohV/rxnmgmEUMJROYiapU6sPgPZbCtMF1schxAdaren0qy9DIa6IJf+JD4Oi5EVlp8=
X-Received: by 2002:a05:620a:46a5:b0:813:6c7:4517 with SMTP id
 af79cd13be357-87373014d2amr691418385a.38.1759346973949; Wed, 01 Oct 2025
 12:29:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250928190624.3735830-1-skhawaja@google.com> <20250928190624.3735830-14-skhawaja@google.com>
 <20250929160034.GG2695987@ziepe.ca> <CA+CK2bDqDz3k0gXamJEbKUL7RPBLVjaA5=Jum=CF84wR+50izA@mail.gmail.com>
 <20250930135916.GN2695987@ziepe.ca> <CAAywjhRGrGjZK3jQptieVWmdzvjfNtTYrp2ChTZJSmFyrBaRqw@mail.gmail.com>
 <20250930210504.GU2695987@ziepe.ca> <CAAywjhRQONuHsxTGQZ5R=EJbOHUD+xOF_CYjkNRbUyCQkORwig@mail.gmail.com>
 <20251001114742.GV2695987@ziepe.ca>
In-Reply-To: <20251001114742.GV2695987@ziepe.ca>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 1 Oct 2025 15:28:56 -0400
X-Gm-Features: AS18NWAgzH0R_qApV1olEBzdsQ5SwFOWeLqmballrV_7tsox0MHuJnbyv7tMWY8
Message-ID: <CA+CK2bAvnTTz+vPg7v38_1dajRZQHyPQ8iDmziiW8GFUqy6=Ag@mail.gmail.com>
Subject: Re: [RFC PATCH 13/15] iommufd: Persist iommu domains for live update
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Samiullah Khawaja <skhawaja@google.com>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, iommu@lists.linux.dev, YiFei Zhu <zhuyifei@google.com>, 
	Robin Murphy <robin.murphy@arm.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Kevin Tian <kevin.tian@intel.com>, linux-kernel@vger.kernel.org, 
	Saeed Mahameed <saeedm@nvidia.com>, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Parav Pandit <parav@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>, 
	Vipin Sharma <vipinsh@google.com>, dmatlack@google.com, Chris Li <chrisl@kernel.org>, 
	praan@google.com
Content-Type: text/plain; charset="UTF-8"

> > 3. On FINISH, the IOMMU core updates the context entries of preserved
> > devices to point to the new domain.
>
> No, finish should never do anything on the restore path, IMHO. User
> should directly attach the newly created HWPT when it is ready.

But, finish is our indicator that a particular session (VM) is out of
blackout, and now we are free to do slow things, such as
re-allocating/recreating page tables. Why start it before a VM is out
of blackout?

