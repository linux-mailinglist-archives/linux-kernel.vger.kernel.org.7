Return-Path: <linux-kernel+bounces-852216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 66EFFBD8745
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 11:33:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E219234911B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 09:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C43B62E8E08;
	Tue, 14 Oct 2025 09:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BVFDxeu9"
Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7631B2DCF6B
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 09:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760434435; cv=none; b=I9IdS3cU6jJDFM3ZQdPTn2yUqrixtV7slkx6AGlqv02RlDAf6nMby0pcTfMgfetdBKyuCYX2TNaoRoMYFst564SIUSJMehOUztmPl3NNyc9LWlIecqeB5jq86xDCiYwunO/SdrucvC6luTeASEFJCNTGyQ+kXXsxKv/jk3Edm3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760434435; c=relaxed/simple;
	bh=8wFGb+P6Qf/XcLDEtfjYh8pZaciaCzeT304mu9deWtU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IFpjfn5qwcGaI/ufk4ZmslY+ma4WdjkTs4OmTuN7NjFXZukq/6VKxHA9inep8FXIse1+BmHZkfURDRNRZioCP7sw3Rz12nOasQgYZn309xvk5vf2A3tr1Awn/8KTMtegcV+/gxXvNhyV5jEsnDx1hq1HPzGaZ+eSamVU72QfWlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BVFDxeu9; arc=none smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-633c1b740c5so5125487d50.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 02:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760434432; x=1761039232; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8wFGb+P6Qf/XcLDEtfjYh8pZaciaCzeT304mu9deWtU=;
        b=BVFDxeu9UAHm62tYlcq8bp3zEcHXubENnevP1qp37fPe4zqSs9xKhtwr//FbfcvZQH
         xVlm0Ayc97PHkYPunP4ObOUVOPBBqDJY8HdBGkrNS0YcNl7ElmQFf0X7m9LGrWOd4mXs
         7Tnmlvron8JnlKlAz4g73HMX3ku/cToeWYGeF4dX6lAYBhsDgon7JlOTrk7+3TP2MQTY
         wzEX3RekaqMkvsaBT9QzX+Go50RjPlHYbk1IcoxJ01Rkhb07mUFEe5iNmhbGakx6Pq6j
         SmbOhTLeCZlGnDzvhYraMygAe9e5we3CNLCTRTZKfWfM1EoizB5stFcLdBHRrsK7HXzw
         CDcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760434432; x=1761039232;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8wFGb+P6Qf/XcLDEtfjYh8pZaciaCzeT304mu9deWtU=;
        b=kAOyMJ7wliitOucTsXu1Sbpo6yiQeDmQstlyqgM3Tr7oXzCrN8fAS46juYIH+gp7wd
         17vOSq9dM7r1KTsqYs2JsXH86uCW4wiflYO1afhDVci+20F4FyKYGPy38o2VOJLwGWJU
         ucYyer9g0yHF7AJQ/mV3bMuuYJxY9PT1/LCOov8UOTwa3Fbwk2nDtpDbvxjxHCSrs77b
         PiLXZOuj6qKfOzL6FR9XLADH41N6Mfr21L+Dmr7/7mhw9/y8MNkqH/oX1hPK8r3s0PWd
         l5PEkt3RYfcIX8aPA2Lp18YKESFDozoyaCuiIaHtvGRbBlGKQX9Ov2+vBUSNdn3P0tt4
         LfNw==
X-Forwarded-Encrypted: i=1; AJvYcCVEzn6//Q7UE7hfxPHJ7+6vN6EHW+cagPnHlCPjPV5tCxCZOY10E/srpINQ3/kSeW8FeCDQ4sT8IvTEqZo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbR3V3yZ/imkG854AkrEmkQEQRTCbfYpdo83WM4uD6Xe6z1ZXS
	kdAjfOEzFFsTG503oIiL2Yyg2TMPNbCCVn0arWaGqW5rn1CEavyzi1tibGuQPaNjC9f7lvulQRo
	NY0dUs2hD5gzfumArz33RWXBJ6fgyrjIy6lLrgnYrPg==
X-Gm-Gg: ASbGncsqCdeaauzhSo4du9KBiBo+Ne8exQPLFH/ps4dJJkUQeDGWzLuGLTl7x0BfpvP
	AmkBshG+ccFe0qsvDLGp25zbBe+1oyiKrxsrzDdSmls+iSinpfm5QoQ/LZDVTkeKohpysjBa+Gz
	nSK5URoPjsEezP1Dd4qv4livKZPFN0JhIVshWEmn8cx9Mv8MJ1Ys8B/id8TsJ4krCsKO5idD+XX
	XXwZY+183klI9/vpdguveyTXLOiOQ+cMvQSB5TrIw==
X-Google-Smtp-Source: AGHT+IEVAcBgpKukciYohw1wCwJ8jfYbDXJ1NWWrLl/ErpkjYcOrlZeCm8gZtEQqr9rX8i9Rb5qXoqV704XMyy0SQaM=
X-Received: by 2002:a05:690e:5ce:b0:62a:38ab:fc31 with SMTP id
 956f58d0204a3-63ccb884e07mr15614598d50.14.1760434432414; Tue, 14 Oct 2025
 02:33:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251008201955.3919537-1-salil.mehta@opnsrc.net>
 <86v7koxk1z.wl-maz@kernel.org> <CAFEAcA8=yhQ-ygoA-fqxzwg69OkdW2nBM0O9X3Lmww4eXuVMWA@mail.gmail.com>
 <867bwzxe9r.wl-maz@kernel.org> <CAFEAcA8FhgcaM_OsHKB3+3Z7B_oZJqU4LHX_j9p-ZQrHfWGX7g@mail.gmail.com>
 <864is2x6z9.wl-maz@kernel.org>
In-Reply-To: <864is2x6z9.wl-maz@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 14 Oct 2025 10:33:40 +0100
X-Gm-Features: AS18NWB0dxb3QuiGrXXZa4EKTtJHL1ovA0YXo63pfaPZJFoM4HjU0WA6QQyO8lQ
Message-ID: <CAFEAcA_gz3C9gJBT0wRbymc7BsYb0VhKqbDRBsLXG=aDAo3yPw@mail.gmail.com>
Subject: Re: [RFC PATCH] KVM: arm64: vgic-v3: Cache ICC_CTLR_EL1 and allow
 lockless read when ready
To: Marc Zyngier <maz@kernel.org>
Cc: salil.mehta@opnsrc.net, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, salil.mehta@huawei.com, 
	jonathan.cameron@huawei.com, will@kernel.org, catalin.marinas@arm.com, 
	mark.rutland@arm.com, james.morse@arm.com, sudeep.holla@arm.com, 
	lpieralisi@kernel.org, jean-philippe@linaro.org, tglx@linutronix.de, 
	oliver.upton@linux.dev, richard.henderson@linaro.org, andrew.jones@linux.dev, 
	mst@redhat.com, david@redhat.com, philmd@linaro.org, ardb@kernel.org, 
	borntraeger@linux.ibm.com, alex.bennee@linaro.org, gustavo.romero@linaro.org, 
	npiggin@gmail.com, linux@armlinux.org.uk, karl.heubaum@oracle.com, 
	miguel.luis@oracle.com, darren@os.amperecomputing.com, 
	ilkka@os.amperecomputing.com, vishnu@os.amperecomputing.com, 
	gankulkarni@os.amperecomputing.com, wangyanan55@huawei.com, 
	wangzhou1@hisilicon.com, linuxarm@huawei.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 14 Oct 2025 at 08:44, Marc Zyngier <maz@kernel.org> wrote:
>
> On Mon, 13 Oct 2025 17:48:44 +0100,
> Peter Maydell <peter.maydell@linaro.org> wrote:
> > I don't object to the API inherently (I don't care whether we
> > do these register reads via a dev ioctl or something else,
> > from userspace's point of view it's just "do some syscall,
> > get a value") -- I'm just objecting to the kernel's
> > implementation of it where it might return EBUSY :-)
>
> To me, EBUSY has a clear meaning: you're otherwise using the resource,
> and you need to relinquish it first, while EINVAL indicates that the
> kernel doesn't understand what you want.
>
> As I said, I'm happy to look at reducing the locking to only the
> target vcpu in the case of a sysreg being accessed, but EBUSY will
> stay.

I don't particularly have a strong feeling about the errno
value. I just think that it's much harder to accidentally
misuse an API which consistently returns an error if userspace
tries to call it in the wrong context, than if it
mostly works but occasionally fails.

(The horse has bolted for this specific case, of course:
if we made it fail consistently then that would probably
break existing deployed QEMU versions.)

-- PMM

