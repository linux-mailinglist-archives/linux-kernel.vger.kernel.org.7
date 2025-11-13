Return-Path: <linux-kernel+bounces-900091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC00FC59951
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 19:56:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 470D83AD12A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 18:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11E96318121;
	Thu, 13 Nov 2025 18:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EcYI1pUm"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A1030FC21
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 18:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763060105; cv=none; b=ueMJXcj/tricxlKhC9eEuK7W718utN7lOf5O/OU4Q73YTkAgMj18wiUFUbUiJMofULBz2q2MwqA93QuA03KJEXGhaJ/r/9KvVpGuSj9w6fHjs8t9zAoax1rDknTJYFvLR3Go+kzDXj7TwSOYEs01BvagvpiFxArYHCpS9pfC5oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763060105; c=relaxed/simple;
	bh=yoiGfSOa9IZY87D1XAPbPP+LEBcGhTWrEyGhdUuWork=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rLX3VsaLpQZOHsB9oW3SCy6z3ehxSJbVoiWMu9MdzUuZvfm+oF7PKkN8TW1Oh++qIQM+tpXl4zWx9IzWQ61/AM36SEpS7q7Qad80bEOJ+zw9wSV6LxOHnkHaThbNYVoVgEtsw7OffgSBeQIMAohnYjfQM9tlwIr2b7cbdDI2MPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EcYI1pUm; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b9b9e8b0812so2588075a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 10:55:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763060103; x=1763664903; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yoiGfSOa9IZY87D1XAPbPP+LEBcGhTWrEyGhdUuWork=;
        b=EcYI1pUmFL4lseAYFSYn1MT/8ekjL0+OmDKGnVl2JqGJddKSRppGJIA/shfkhK0RrO
         OR3sxI9sjGBvhrXoUH92Q4C785njZxKNCxqvld7NOqHe4HpcWSQNXfDj0j9KVuEi0wOH
         NzsXW81wFMSk36YtFZA2QeTOlUyiEYddkFG9+eE9Ir7jN+xCfUjI+9lOLamjhvOvJkSp
         4GNfXqFeZyrIdQ7FvFjtR4MdonUicGlIAxNWQWNgGPQOBPytqF0J2l5prNISUDybqA5s
         sj2GyEdLvgVfynYNjEfHo4Y0vni1veqnHHd0Mk9WNOjTj+gmbt94JsNWEx8eniLBy0UU
         Cejg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763060103; x=1763664903;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yoiGfSOa9IZY87D1XAPbPP+LEBcGhTWrEyGhdUuWork=;
        b=eK33UuyU42eW6pak5jKxHrcLP5M6Sqi1hAfJqYUPdsPbUKUO+7Z1qKAi91zXenDn8K
         hy92Pmi/D6uS+BSgzaNGOu2LbEw+mxi81pPMvFWjg/MpamwAfWx5g605LoeOtFwVzKqo
         h4EOPELqvAhBioyvYUPQLc9+Skfz/Dh7bLZNQBDFqzUdYOmDeofkRc9B7JNHpkiwseHR
         4/ruFzOW6Cqdo6+gbrSqJtRKauOIYYciItih5jT6q9BOjsSmoCHtDR71udlNWiy7BMtg
         wwHWhQIh00jcPAmguySPGTODswoj+Zau0vSmVTHblRj48CsFvx3YlI4w8/MjPoyEXV1t
         1P+A==
X-Forwarded-Encrypted: i=1; AJvYcCXTWo9Ufgm1b9x7WENZHQUWLLdweNtLJSWd/j5XXlG561Jr3DG7UpnYJA13591d11lqD54Vn/BjWUvXHaE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyW0VgDxI8gVKZzuXGXThrz+XQG6qPkmxWr/8FFQFC7NmFw37CX
	u8EyjNPUffmUow2/mrOXuuziORmZvXCLCVlvwDlSvVGdeRA/VELG6/DEvPpMgog9oSJWNuzLjWd
	ud5NalA==
X-Google-Smtp-Source: AGHT+IEKxb5eXFzXsmYoUeXSmHh0/xueNTZwDkOb8m+X/4sGuTjMIch3iG0R64oLCQ33S67TXLy6hrtPviY=
X-Received: from plpo6.prod.google.com ([2002:a17:903:3e06:b0:297:d489:2ecd])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3b8e:b0:295:32ea:4ce5
 with SMTP id d9443c01a7336-2986a6bd29emr601245ad.6.1763060103243; Thu, 13 Nov
 2025 10:55:03 -0800 (PST)
Date: Thu, 13 Nov 2025 10:55:01 -0800
In-Reply-To: <4161146b195efee57393b65f8e9022d4bc7e443e.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251112171630.3375-1-thorsten.blum@linux.dev>
 <4a2a74e01bfd31bc4bd7a672452c2d3d513c33db.camel@intel.com>
 <aRTtGQlywvaPmb8v@google.com> <0d9e4840da85ae419b5f583c9dacee1588a509ba.camel@intel.com>
 <aRYHVHOex4zkyt5z@google.com> <4161146b195efee57393b65f8e9022d4bc7e443e.camel@intel.com>
Message-ID: <aRYphTF5Yjb_Dd-B@google.com>
Subject: Re: [PATCH RESEND] KVM: TDX: Use struct_size and simplify tdx_get_capabilities
From: Sean Christopherson <seanjc@google.com>
To: Rick P Edgecombe <rick.p.edgecombe@intel.com>
Cc: "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>, 
	"thorsten.blum@linux.dev" <thorsten.blum@linux.dev>, "hpa@zytor.com" <hpa@zytor.com>, 
	"mingo@redhat.com" <mingo@redhat.com>, "tglx@linutronix.de" <tglx@linutronix.de>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kas@kernel.org" <kas@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 13, 2025, Rick P Edgecombe wrote:
> On Thu, 2025-11-13 at 08:29 -0800, Sean Christopherson wrote:
> > Assuming you're tracking linux-next, I wouldn't bother adding kvm-x86 a=
s kvm-x86/next
> > is fed into linux-next.=C2=A0 I do push to topic branches, e.g. kvm-x86=
/tdx, before
> > merging to kvm-x86/next, but at best you might "gain" a day or two, and=
 the entire
> > reason I do "half" pushes is so that I can run everything through my te=
sting
> > before "officially" publishing it to the world.
> >=20
> > All in all, explicitly tracking anything kvm-x86 would likely be a net =
negative.
>=20
> Yea, linux-next and Linus releases. Ok, we'll leave it. I was just thinki=
ng
> about your lack of TDX testing setup, and wondering if it could help. All=
 good.

Heh, I appreciate the offer, but you probably shouldn't encourage my lazine=
ss at
this point :-)

