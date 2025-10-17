Return-Path: <linux-kernel+bounces-857078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8419BE5DBB
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 02:10:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B9A34026F2
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 00:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9D0878F3A;
	Fri, 17 Oct 2025 00:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GalH2AOb"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA3D1C2BD
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 00:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760659808; cv=none; b=Ui8WOOPuIxhjarl/WFMMhZT2o66sgDXf3Cnu6ywnu6czCOik8PbqayV63joje/KM3QtNvq02PG2LRE11dyrq+Wm+uH+ZIvOZwOJrz3I1t1V1B7gT8mp1xBsv+JlrgMh2pOpPtQFO0bIIuybQ1h6tJryp5SAJoSYCyOzeZHlSc9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760659808; c=relaxed/simple;
	bh=E1AC9iyyw2ScMA/Vd6Wp/4knwNlCQVVOev8xoskItFw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zxm6Ntm3H26fgK9TM/NyKZhuALfNx9D1oujrZI2KGEMKuPkEf8nAPP6yN0zTshfPigShoTKmC8zvIoSL+NguOv2/Uztj3PjanE0ELBAz/fCw4HyAdq+Hc9LmlYbbqd7q0jcx4KIofBVGi21nWV8E25wQ/Wa+iwpDrEYroK3cp0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GalH2AOb; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-290dc630a04so143065ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 17:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760659806; x=1761264606; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E1AC9iyyw2ScMA/Vd6Wp/4knwNlCQVVOev8xoskItFw=;
        b=GalH2AOb9ugD/EnLU/YjEXztTOrnDPpnpfcBJcj0d/MNGzyaVeWapYmBzJ5dVgVdUO
         GrBkGeCFw55ow5Lnm/9H1x5k0uwtclYMP3oKGykA0AZ45a+pylS5YIf1v1y1hl2/4zTo
         UfLjnpNxUCyyefC3cLb6UtyJ0cII5gosaBzkGh9BkOxfuJLDemvsD1yrvfiIGEVLUxZx
         /BdAfDzvpK+s0adOXt/WqIGe4PtXqjFiPB5znTGtB8LdYVEFiIKGpp2Ik0tIyno3Bhu/
         B/xTMdudwoJ22Z5o1lDMt4ucEnTCZqCwaSzOjTMrTiMoKSgU0f8eBmRnpC+Ho0opLJNo
         bWKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760659806; x=1761264606;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E1AC9iyyw2ScMA/Vd6Wp/4knwNlCQVVOev8xoskItFw=;
        b=A80TO3muPoiDk9scCMAfr1d+zZ0sxQCufeOM3d2aD3XhCityJqxfdChbwdYL5WMRfj
         e92+0/6/5EVpWyzu8pkyG2Ko1uj9ADdy36h9FPY/xiEHLlaWpOqkYQ4WXf9JaJI63VJE
         YlSU31S2ZTrYjqhLVv/Rg6lPKzLuUNbAszdtOEKOVcwewzUVdykusrBSOo9fEINmKnNv
         alUNt7lsms6YbL4tu1X02YR72tTU3/kQTWTqyXWOzQvfCRAyFAOeFxq7NdWRf9kVonlw
         OTMDKXRd/u9jqGlKjp4yOF1p4CDIv4L81Zy0Z+vcbrhRu3qRZMUV+DYwob9qBTs22OEo
         SlKw==
X-Forwarded-Encrypted: i=1; AJvYcCWpY6ocawZPr98xJNWRASVjcwbhPqcLtThWSjS2TtoLnP1YLSnorA/bbG48H4yFr7CTLEitiXksLSIZs2E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBnmZcCDRN3v2CXawLEHkgzGifTYfYczw4si5I9AhKOKDG3c5L
	2A2qkLQXN3jasL9iGXvWveAOnWKbDOqmpTdXYyHv6qF39WOYt9gfGfDhcV1zYc/SVEkPQq7VAvG
	VqqeldtATh7yO2+pFJ1plWdL5/CeLx90=
X-Gm-Gg: ASbGncssXWs+UzYgWTecoY0vpzWdvoOannrFFG0Z3tN9eryKk5QVgxJ5ecZPLzljaFO
	IiDBLVRYeftx3s1uoy1zgUiH04PkV+jHTJnTlLcJmLShyfRU7yd2+r4WaXA5bqe4U5lO5V0uZc/
	AxULmIMbZGuC4fJCYA0Bj1KEs26F9nkQRb3XomfsBw1oNzxJWmZJi6kMzu/wCTbXQ/8I6eTRoG4
	H4TKPGlTwq2axWdJ1Z/5YO+Bw9zwHs8ezo1FD8vRdN/bEQIF1R9ZeC77BX0cXKg3wh4V3wspS5Q
	i1tZul+T5QyuER/N3JER41dGPoK1jaHEYcPkeYumnffuAAmUeGLeUiO96FYrzCT8cagEz1HORH/
	emSN87YirJrUu0A==
X-Google-Smtp-Source: AGHT+IHyIQx0yThg9KT154kOAtD8f8239Y2M/cEMXBlvtxveyWdxtgQX335VASRAYK/45RIQjcQyHtpm998s6Nd9ll8=
X-Received: by 2002:a17:903:248:b0:275:c066:33dd with SMTP id
 d9443c01a7336-290cba529f3mr11403495ad.10.1760659806208; Thu, 16 Oct 2025
 17:10:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251016172853.52451-1-seanjc@google.com> <CANiq72ntKAeXRT_fEGJteUfuQuNUSjobmJCbQOuJWAcNFb1+9w@mail.gmail.com>
 <aPFVcMdfFlxhgGZh@google.com> <CANiq72m6vWc9K+TLYoToGOWXXFB5tbAdf-crdx6U1UrBifEEBA@mail.gmail.com>
 <diqzqzv2762z.fsf@google.com>
In-Reply-To: <diqzqzv2762z.fsf@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 17 Oct 2025 02:09:52 +0200
X-Gm-Features: AS18NWCDoiITBSs67Uq2rZ6IBFom-AeoZUx_UgHO9S2h4SATYKwpJteeHcfF5xU
Message-ID: <CANiq72m0rNCaKandZgRa4dMhNOEN7ZanT5ht4kT8FLxYoWLVLQ@mail.gmail.com>
Subject: Re: [PATCH v13 00/12] KVM: guest_memfd: Add NUMA mempolicy support
To: Ackerley Tng <ackerleytng@google.com>
Cc: Sean Christopherson <seanjc@google.com>, Miguel Ojeda <ojeda@kernel.org>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Paolo Bonzini <pbonzini@redhat.com>, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Shivank Garg <shivankg@amd.com>, David Hildenbrand <david@redhat.com>, Fuad Tabba <tabba@google.com>, 
	Ashish Kalra <ashish.kalra@amd.com>, Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 17, 2025 at 1:57=E2=80=AFAM Ackerley Tng <ackerleytng@google.co=
m> wrote:
>
> Using the command on virt/ would pick it up. Would it be better to add
> "virt/" to the "automation" + update .clang-format while we're at it?

Yeah, that is what I was suggesting if you rely on it (and if the
maintainers of the relevant folders are OK with it).

Cheers,
Miguel

