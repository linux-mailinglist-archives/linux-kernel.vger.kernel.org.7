Return-Path: <linux-kernel+bounces-875813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2361C19DF6
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 11:53:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 397FB426CDA
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 10:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CA0032E13A;
	Wed, 29 Oct 2025 10:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U3DBtGnp"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F25E32A3F9
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 10:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761734626; cv=none; b=TETvKsNp+IoLaEfy3YSHANibVVjKVIzhDajeb2i6d7rr6VeP0KLxZ/dXCIBlclRBmPJZKohsBaAGEDlzn88z8jZB/ZXiQW3KelmPmOOFSmcjGyOJ7giOumMxiW3R3nbnH+wr7+xuhdmDRZSk+OwbGiGDVF5ocFGEZkoXV2d6O7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761734626; c=relaxed/simple;
	bh=2oXoC0z5iX1QVctIx7be9YVECKd3qVj+JpFkjgooT/U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VRLOuKTIyDAu9mzKoKO1aqa4hLwY+QeLd90m9mK/OUAdNkSjb+KsotUKVpAVcSQNpAA3pZUJI+Z7laBSSqDoIu0bJRjPakwhIcumFqgGa1AZcFBQM/a8rUti+XG3TgdhRglf4xYH6uWufHL0ulYik10SafXf4RAIhkK0geLYrcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U3DBtGnp; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-4285169c005so3407342f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 03:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761734623; x=1762339423; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HcoHF11ENhR3RrvSYHkD59wUi5AUsDEUQzjKh8Eb0i0=;
        b=U3DBtGnptuySBoVepvxKVciNuLzjA4f+SKmg7g0BuvrqxoloHXBwdNA4F5FVVCuN+m
         1OwQBQa5qhU0MeU+d76nXZSnLq7PB/YuyGIP1pJXy3iyX3gEx9MEnemTqtUjKhN49EN6
         DasjY9uQPLGuNmoirYLtOW/dJIQWucjbtN9CTAueSGTy0ndPvH1XxEYwVbSmXaGhu2Jw
         hHBpgJ5xPuM7HF21x+HBYQLeUR69iT/pj3Uo0Gmopkrz2U1yU9aYn0d7dQFocRu9MR6I
         oHNmYdf0QkWCSgXT3avcBe6Fu//CH4fk198qQ+d448V0TzqNfY/CZ/cX8jsIzAmOJl/o
         GptQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761734623; x=1762339423;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HcoHF11ENhR3RrvSYHkD59wUi5AUsDEUQzjKh8Eb0i0=;
        b=vwvetkQA4OgBh5C68cpPpUy9bhyGdTtGqJktNlQ9h4JZyG8zJCut36xvLJiT722t/Y
         IowjUBlCpftUS6wvHwGpr7st00qHQWFtMOl1ww+gQJjR3X3JAc9HufjcCDsAb8t23gQJ
         aRS/17byuqmF2ff1lwnWGj6+bYkTF7TmEep6D2PHZqk9Wcqgz9H5GLjD3Bj+rbvH10AW
         tSj25uqxreYprJdWdgUDsdVJWRZedNT3OQp80oxdq8KUygTbO5l6BwDIg+JNHyPEufZ4
         GTOgpfw/uAv1NRJ6Zt+lgaj2tjOMuKRHyLZYmnDoj2+hUSTpsJX7U0UfoAs6A0m7qJZL
         S6pw==
X-Forwarded-Encrypted: i=1; AJvYcCUd0Gae03LXtykp2/+0rCn37GFujzg/31m83gcmFIPCFZiu3G3tiodehzbG193whYe/OFfatD7Vc+fFjzg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz62/bj1l4Klax/0H4eLniR1RFisScJIDr7caq+e9/W31Faq7La
	dgUQhSagAaDnn3IsNW/AsuvIIZrTAltuGeV/gmOaS0YmEBqBfRzuWu/B
X-Gm-Gg: ASbGncvV+8od4JvyDCX0zpJqxbJEpe0iVOop5Hi1C1h7OqUkpTMxNfQ47EQU+EbeRYX
	JHc4nWKemoo0spnITLPqmrs6QHpEhjce+jwJx+1PpYAg/IPtPgaaY0CP3QYcBr67ul9meBfmMxJ
	Lo06IjfdCeiPqpCjGXUWEmcyPBGlezSM0eypCyAXtvB6iYnEJ9fdscAoFMldpV7ybj8hw2LYRGR
	OlW8gO6G6scXrkBiDibFzcn71PTkcgCZ80jW3iIRABqkPC522+AHpS9tSaZQiAOYw2BeWJM+MEj
	EgTkkgi759UgsFvSYAeuwL42o4PY1+nxdiUfDZctDPmfVJARsLFGAMCgOdWjP/xHbfTBnfD0LRx
	W6jCQEY4Es1gTUKMiH6NwP6AJrw+xUKRg/DgJztC0OH7V4ndE9sSncLzdlvrunrWhBiu2qtmX8e
	8atLyq
X-Google-Smtp-Source: AGHT+IEmRI4Z/M00oieKbPxeIQldJKpH25/9dKm0itRMgfx3Wj6z2aQjBwr5JnK2lV2Z2mKsh3XAaQ==
X-Received: by 2002:a05:6000:240f:b0:427:a27:3a6c with SMTP id ffacd0b85a97d-429aefda93bmr1775484f8f.63.1761734623193;
        Wed, 29 Oct 2025 03:43:43 -0700 (PDT)
Received: from vasant-suse.suse.org ([81.95.8.245])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952df62dsm28137267f8f.45.2025.10.29.03.43.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 03:43:42 -0700 (PDT)
From: vsntk18@gmail.com
To: ashish.kalra@amd.com
Cc: Sairaj.ArunKodilkar@amd.com,
	Vasant.Hegde@amd.com,
	davem@davemloft.net,
	herbert@gondor.apana.org.au,
	iommu@lists.linux.dev,
	john.allen@amd.com,
	joro@8bytes.org,
	kvm@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	michael.roth@amd.com,
	pbonzini@redhat.com,
	robin.murphy@arm.com,
	seanjc@google.com,
	suravee.suthikulpanit@amd.com,
	thomas.lendacky@amd.com,
	will@kernel.org
Subject: Re: [PATCH v6 3/4] crypto: ccp: Skip SEV and SNP INIT for kdump boot
Date: Wed, 29 Oct 2025 11:43:42 +0100
Message-Id: <20251029104342.47980-1-vsntk18@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <d884eff5f6180d8b8c6698a6168988118cf9cba1.1756157913.git.ashish.kalra@amd.com>
References: <d884eff5f6180d8b8c6698a6168988118cf9cba1.1756157913.git.ashish.kalra@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

   these changes seem to have been overwritten after
   459daec42ea0c("crypto: ccp - Cache SEV platform status and platform state")
   has been merged upstream.

   I can send a patch if that's not been done already. Please let me know.

Thanks,
Vasant


