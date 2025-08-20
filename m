Return-Path: <linux-kernel+bounces-777740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75175B2DD3C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 15:03:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C9BA1C80747
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 13:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C348331A05A;
	Wed, 20 Aug 2025 13:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wW2AcJZy"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9300E302CA4
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 13:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755694905; cv=none; b=iKe9la1Cn0rI3qcOX+MHPAv3bURwW6eZgBe3pb36COuOyrAO/9TBlkuJF4Uh+7NYuj/1bMCvHzY04GLwDqUkSTfH1IQkL6yYDY4W/+XLqSX777n+TVfb+j8c9V8oTxb75zYWyoAAYafaI8pErvT/BjjjBHr9vC/4U97cDPBXNBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755694905; c=relaxed/simple;
	bh=wKs6154q1CuWduyMYGk1ExrTS3G/asrXXyz4KcM+ZXE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BzyOLh1vIoviQ6XNwbFMpsb/DXR2ntpM8Dc61mmW4eioG81w9OGYv5ufU7MH44xHbgH6t6rUcWGaTHgjKJZpmSalaYFwPOR35qZaA3SVW+quP7R4SS7+sk6R6MucEjAcrQdMGFCgtR+cC6MxHLs9mse5FSTfkMh6aZqU/q6AJzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wW2AcJZy; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-24457f59889so70539785ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 06:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755694903; x=1756299703; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UaJOMLSIELpvDEO7epSv+22yc1sPRzaMaQRGyQr0AeE=;
        b=wW2AcJZywjYn2/D9QUY2C8b5aGe38lTRF6hP9WWTGXkXlqziPYscFqcpKoD8OzSRBo
         OspDyeFvbA5TUdQZ0Xfp9nZEf6v98cMcpF+YJx2MKpiaRxbJuVhcQBEN95Kns2QazEvZ
         u34YiLRCc2DBX3MBj1uLXIJi6k03QwvHtxm/wA2XjxesvI6Pjv2LqALJJa9L1Natwk5B
         AtOpkFcE/kWy61HMoBIP/ZvKle+g7Gd5ptKIEEvFSQk9mv0q/wNznmOV46kQqAVD7sP8
         XNpYWUk/45OO88glS/5Ky3iOyXcXw/wC4MOYo+nXZHzA7LVVHSC0HysjMylT4DKTCL2u
         c2+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755694903; x=1756299703;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UaJOMLSIELpvDEO7epSv+22yc1sPRzaMaQRGyQr0AeE=;
        b=RYKJ25/hN79lTKLT9SkU6aH4P+95F7cNNXUwifbOUi86rILUZYlgg1I099Ee95aTNJ
         ECuuM11uzZw12ZI6IQzz87rO2xiLTGv3Si1y6mK6TY2D9G+BbH529oZ2nyZpJDydFfK/
         pcTqUF6KTeM0MxOFQzPPd8tbquHsCZMs7gCrCLPVpw2gAiFdgH2FNI6M15idx38Itlmt
         4gIwND/f6D6a4N7GcpN/h5iNa168vMCPKWGhrwp0NxDFcDdfemQ4lmqbS5iU+MKTrzxo
         iypELqoYOmDPBJQvOWd4G/NGlBCpnoRvipA5PHUAjDhV/g2aeekAtHbgaKlIN311F1ZH
         4Ukg==
X-Forwarded-Encrypted: i=1; AJvYcCWb6TxhPZaWsjV9jkicX6QpNZuA83bEzP6IeCa2KR5bBh6rYk/emhSyoAIatvjwixAzUroJx2Rc14G2Krc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywof5XMhbGDvG6pUSj6RI0Y/52ZH8DzJs342tqd/lJ0giweK7t9
	Ia1Ab8TRyhpj5jXMn1BrYsXxqKdoKShW2y8/lJW3GVeqxhT8YogXig/Bmar13BzjNQmB5EEPNOD
	zHySuzA==
X-Google-Smtp-Source: AGHT+IEwOh08V7OwFaToRvymHqAkp1iuuPWnLNS6JSQCMW6zILVjkhJt5JbRAqseXO9ZLDriDY4AFd/fiY8=
X-Received: from pjbok13.prod.google.com ([2002:a17:90b:1d4d:b0:321:c2a7:cbce])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ef01:b0:243:3b1:47cb
 with SMTP id d9443c01a7336-245ef1045a8mr33382985ad.6.1755694902882; Wed, 20
 Aug 2025 06:01:42 -0700 (PDT)
Date: Wed, 20 Aug 2025 06:01:40 -0700
In-Reply-To: <c3e638e9-631f-47af-b0d2-06cea949ec1e@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250819234833.3080255-1-seanjc@google.com> <20250819234833.3080255-9-seanjc@google.com>
 <c3e638e9-631f-47af-b0d2-06cea949ec1e@amd.com>
Message-ID: <aKXHNDiKys9y8Xdw@google.com>
Subject: Re: [PATCH v11 8/8] KVM: SVM: Enable Secure TSC for SNP guests
From: Sean Christopherson <seanjc@google.com>
To: "Nikunj A. Dadhania" <nikunj@amd.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Thomas Lendacky <thomas.lendacky@amd.com>, Michael Roth <michael.roth@amd.com>, 
	Borislav Petkov <bp@alien8.de>, Vaishali Thakkar <vaishali.thakkar@suse.com>, 
	Kai Huang <kai.huang@intel.com>, David.Kaplan@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 20, 2025, Nikunj A. Dadhania wrote:
>=20
>=20
> On 8/20/2025 5:18 AM, Sean Christopherson wrote:
> > From: Nikunj A Dadhania <nikunj@amd.com>
> >=20
> > @@ -2195,6 +2206,12 @@ static int snp_launch_start(struct kvm *kvm, str=
uct kvm_sev_cmd *argp)
> > =20
> >  	start.gctx_paddr =3D __psp_pa(sev->snp_context);
> >  	start.policy =3D params.policy;
> > +
> > +	if (snp_is_secure_tsc_enabled(kvm)) {
> > +		WARN_ON_ONCE(!kvm->arch.default_tsc_khz);
>=20
> Any particular reason to drop the the following change:=20
>=20
> +		if (WARN_ON(!kvm->arch.default_tsc_khz)) {
> +			rc =3D -EINVAL;
> +			goto e_free_context;
> +		}

Based on this conversation[*], both Kai and I expected KVM to let firmware =
deal
with the should-be-impossible situation.

  On Tue, Jul 8, 2025 at 9:15=E2=80=AFPM Nikunj A. Dadhania <nikunj@amd.com=
> wrote:
  > On 7/8/2025 8:04 PM, Sean Christopherson wrote:
  > > On Tue, Jul 08, 2025, Kai Huang wrote:
  > >>>> Even some bug results in the default_tsc_khz being 0, will the
  > >>>> SNP_LAUNCH_START command catch this and return error?
  > >>>
  > >>> No, that is an invalid configuration, desired_tsc_khz is set to 0 w=
hen
  > >>> SecureTSC is disabled. If SecureTSC is enabled, desired_tsc_khz sho=
uld
  > >>> have correct value.
  > >>
  > >> So it's an invalid configuration that when Secure TSC is enabled and
  > >> desired_tsc_khz is 0.  Assuming the SNP_LAUNCH_START will return an =
error
  > >> if such configuration is used, wouldn't it be simpler if you remove =
the
  > >> above check and depend on the SNP_LAUNCH_START command to catch the
  > >> invalid configuration?
  > >
  > > Support for secure TSC should depend on tsc_khz being non-zero.  That=
 way it'll
  > > be impossible for arch.default_tsc_khz to be zero at runtime.  Then K=
VM can WARN
  > > on arch.default_tsc_khz being zero during SNP_LAUNCH_START.
  >
  > Sure.

https://lore.kernel.org/all/c327df02-c2eb-41e7-9402-5a16aa211265@amd.com

>=20
> As this is an unsupported configuration as per the SEV SNP Firmware ABI S=
pecification:=20

Right, but what happens if KVM manages to pass in '0' for the frequency?  D=
oes
SNP_LAUNCH_START fail?  If so, bailing from KVM doesn't seem to add any val=
ue.

>=20
> 8.16 SNP_LAUNCH_START
>=20
> DESIRED_TSC_FREQ
> Hypervisor-desired mean TSC frequency in KHz of the guest. This field has=
 no
> effect if guests do not enable Secure TSC in the VMSA. The hypervisor sho=
uld
> set this field to 0h if it *does not support Secure TSC* for this guest.
>=20
> > +		start.desired_tsc_khz =3D kvm->arch.default_tsc_khz;
> > +	}
> > +
> Regards,Nikunj

