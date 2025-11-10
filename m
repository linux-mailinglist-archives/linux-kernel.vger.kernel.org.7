Return-Path: <linux-kernel+bounces-893855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CBBC3C4883F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 19:19:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1C79C4ECF02
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 18:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9DE932AAAF;
	Mon, 10 Nov 2025 18:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZZKa3gmn";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="KNQRksje"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55FAF31CA4E
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 18:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762798763; cv=none; b=pN1xyD6TN3QHDlnVCDbi9GJYhii4n5e4ipI77ld8YPN+K3L3tQQP6voffgvvIoiFRAcu7roNi0WIee1cYacQYfVgcM6Qhcc6YzSoCcgddzQWPCt8Uhb21uxu5EGLPI1uTVENY71Eftmj+MLbWuY483YhL2+mHnTOmpS9P5S5VAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762798763; c=relaxed/simple;
	bh=1QZl5r7sIr5sRRuRRJHMFTSX73wHJTLDlyXpkcHSecY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oCH9Ltm7sB07cC4JROEN998s2tNSOV0NE6bxjecHEjEQ3BrhW3HdUiogyLEywDG4pSSKFA8/g2Z849l52ly4B/ZRJiRskCKdifYw8lpkdg8wgwAp1Cg+gw0xUbkQZby8mwKwfVu61IX1VntdfFQX/D9h+FEP+CcBW6fHoA+wSuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZZKa3gmn; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=KNQRksje; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762798760;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LhvLst+P0pIwwi9pGBO2xXY1tmD2l0kTSuuyImpVM8c=;
	b=ZZKa3gmn5HmzhDrp9NL2BQWe3/Yk+hHDAZKvpLGQ5KkvQifFyGrHKIstghbTO/2VTPKt8G
	ygn5tHLklouTP3Oe8+PqT7/arEBrNXhUUenTrdANhYgI+HhuPjXAseVrhTz++rUUvfNDns
	Gc9KX9nS8+IKvtJRU+J0smHe3j3aoGQ=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-296-_lALR6b_OSarSvpBt3F3lg-1; Mon, 10 Nov 2025 13:19:18 -0500
X-MC-Unique: _lALR6b_OSarSvpBt3F3lg-1
X-Mimecast-MFC-AGG-ID: _lALR6b_OSarSvpBt3F3lg_1762798758
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8b2217a9c60so746415585a.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 10:19:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762798758; x=1763403558; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LhvLst+P0pIwwi9pGBO2xXY1tmD2l0kTSuuyImpVM8c=;
        b=KNQRksjevAIiH6YwujA+jWfvLIShPEja2YEmM+hHr+G/va/eTyl1SRVghRamTfvMlq
         KWB0xJ82Fm6k3Tb09rbml1I7VCi4zUmfPz7/Tc1ZXuxiTsnEsyHloMuzfHE3NjiwzOdh
         p6i6F5Vp85moIShLDaaaRJEyV6h/5yTLxbNTKrdyoBwKli55U9rHBRvSLIQ4x1mCHNZ8
         Tq5fIe7Xrd6Ql6n0xtzCXIzJ52B3MEwE/ZLP0WbwA83QRRltJYvnh+qxPbT+zakOA5B2
         vE+AEhwWUY6fc2Sf7QHkPISAsN5eA8g+BWP3PCquSAemFAW+PZmzcTuAF/DlBnBCrWNh
         QUGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762798758; x=1763403558;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LhvLst+P0pIwwi9pGBO2xXY1tmD2l0kTSuuyImpVM8c=;
        b=LuPsEUQVggs4ZJJIL9YIXd/QZhR+EHxS3LQEqyLszPCDH5KBC02R8A8BmdHfE6bVDs
         rLi574wS9ni9oM5s0b/Bxf8OHRWEhEpN461KxJYb14KFrIj0PCg8ftx4F0U5tmmZcCBx
         0rUrCRw0RDNH755flxHH17pQr5oE1xqzjGeMLXvjwQCkDgXH14Y//X5bO6/6oFpBqWcX
         VTrrHoz5lD85PAaYuodyRILwMmwV01Qu/99j9bnJxAKHff6XyDy3Ja94337nzEwD3O8I
         9SMLOg9EPjtNGZ3zrSe+tXeTCwXupSkQ8QkwTC+sdxSwS6CY3Rha90CCgud92ssUYtgW
         3PwA==
X-Forwarded-Encrypted: i=1; AJvYcCWIlr4kZYbnw8omvNfKDu2D+2FzzG6FpMAInQwq7oynRG8mHlHcUT6HYYBWDURjb7aXFh35UVbOwmWfbR4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoqCgWU/92IeqGYW2Xeuor2cl5z1UsJRaU3UZdIjxz79Wzcs4W
	JFFdr5kabX6tDPz02wBXes7Ut+CIpBnSfkojYDt7GI3z1LFtnPwr6gk9JKI3otvkbLLweAcA28R
	aLi/+JAPuxu5IiDaSkmlqDpL8jIhosjlRVSVtDHM4KMBnm6648hn4pemYV/pk8YtkJg==
X-Gm-Gg: ASbGnctGNa9PgoZ2X+870jf+ibWlpEM2RtkmdAihlKEWeC0psWhjTbfEWrKq/pvTzII
	xypoOWESjub6bvxRGhoCweFw2F27Kpb+UbEoW3y6cZW89GNzXFURMwZs3dX9TXVAR3bjGD3bgTv
	9100/tAxIx+R3dnf8vUqjcz13mTJalNUnCw1Ia0aF12AqoGyXQYncVPugrLkl5yFAsW9gGfgz9P
	zQPfjQzBIRVlU8PKysRnn0FSdPLkZFB6IMY3xF4z0c9nyIdxQoWVolu8BJgXmeU/b46HrtnADPb
	W334c+mBTQIqlwxATSdvCFi9BW1AetQanNked/epGuIIqfmSnICBlam+6gQctSvNHKdW3/ctSTD
	sHOwIQvftHAgWG2ay2oGkY5xsfXBr3DeVeyabwI8NJFs2Xw==
X-Received: by 2002:a05:620a:1790:b0:8a3:87ef:9245 with SMTP id af79cd13be357-8b257f76956mr1198804285a.85.1762798757993;
        Mon, 10 Nov 2025 10:19:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF+PJnuQIOmozkDYCSrliPkbbXo0Xy49cuqoebK2tXkzI9uYUruFfyTQDfTiP6bVgjiW7/jHQ==
X-Received: by 2002:a05:620a:1790:b0:8a3:87ef:9245 with SMTP id af79cd13be357-8b257f76956mr1198799985a.85.1762798757576;
        Mon, 10 Nov 2025 10:19:17 -0800 (PST)
Received: from ?IPv6:2607:fea8:fc01:8d8d:5c3d:ce6:f389:cd38? ([2607:fea8:fc01:8d8d:5c3d:ce6:f389:cd38])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b2355e776esm1037884585a.21.2025.11.10.10.19.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 10:19:17 -0800 (PST)
Message-ID: <36f35af3070673c6b0b899ab34724f05ece36fba.camel@redhat.com>
Subject: Re: [PATCH v2 0/3] Fix a lost async pagefault notification when the
 guest is using SMM
From: mlevitsk@redhat.com
To: Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org
Cc: x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Paolo Bonzini
 <pbonzini@redhat.com>, Ingo Molnar <mingo@redhat.com>, 
 linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>, "H. Peter
 Anvin" <hpa@zytor.com>, Dave Hansen <dave.hansen@linux.intel.com>
Date: Mon, 10 Nov 2025 13:19:11 -0500
In-Reply-To: <176278796977.917257.9553898354103958134.b4-ty@google.com>
References: <20251015033258.50974-1-mlevitsk@redhat.com>
	 <176278796977.917257.9553898354103958134.b4-ty@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-11-10 at 07:37 -0800, Sean Christopherson wrote:
> On Tue, 14 Oct 2025 23:32:55 -0400, Maxim Levitsky wrote:
> > Recently we debugged a customer case in which the guest VM was showing
> > tasks permanently stuck in the kvm_async_pf_task_wait_schedule.
> >=20
> > This was traced to the incorrect flushing of the async pagefault queue,
> > which was done during the real mode entry by the kvm_post_set_cr0.
> >=20
> > This code, the kvm_clear_async_pf_completion_queue does wait for all #A=
PF
> > tasks to complete but then it proceeds to wipe the 'done' queue without
> > notifying the guest.
> >=20
> > [...]
>=20
> Applied 2 and 3 to kvm-x86 misc.=C2=A0 The async #PF delivery path is als=
o used by
> the host-only version of async #PF (where KVM puts the vCPU into HLT inst=
ead of
> letting the kernel schedule() in I/O), and so it's entirely expected that=
 KVM
> will dequeue completed async #PFs when the PV version is disabled.

True, sorry for confusion.
Thanks,
	Best regards,
		Maxim Levitsky

>=20
> https://lore.kernel.org/all/aQ5BiLBWGKcMe-mM@google.com
>=20
> [1/3] KVM: x86: Warn if KVM tries to deliver an #APF completion when APF =
is not enabled
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [DROP]
> [2/3] KVM: x86: Fix a semi theoretical bug in kvm_arch_async_page_present=
_queued
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 https://github.com/kvm-x86/linux/commit/68=
c35f89d016
> [3/3] KVM: x86: Fix the interaction between SMM and the asynchronous page=
fault
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 https://github.com/kvm-x86/linux/commit/ab=
4e41eb9fab
>=20
> --
> https://github.com/kvm-x86/linux/tree/next
>=20


