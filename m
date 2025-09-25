Return-Path: <linux-kernel+bounces-833005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07368BA0F59
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 19:55:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB069628071
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 17:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4755931158E;
	Thu, 25 Sep 2025 17:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kEMfcTgF"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02FB92DCBF3
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 17:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758822903; cv=none; b=P0OjY0PXgNBrhJ5fF7sNnUJ4aTxUG9CWiraaGuN84uV/CFbajiyHZg0tRErokOxgCJRCG+4bpIZ+P6TyPAfrWRI2AtFk9VhMdJGkJZnOiPvVfUIxrg+dy7ZzSwNtz8U/k/GpOTP5VUiNQ09thxokdxB3oCq3lRGD34x6OlqrHEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758822903; c=relaxed/simple;
	bh=nbPCHfJ+LLlBruT2Jb9S8w0HTGCja4pN4K+XH7Xc4jg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vdp71nU/vK6K2AwE5uRe0Ksa+moLJh1DGUZNaeRhqyZvcrOYnrSZGFF0xosGQ0N7MNxLWkvMGjfyq5/JAn33dKpaoLhq/nXfbcV9CBm4M+1ldhDRtJAkCygR59YOPNKyV3TCJ6VIfTOuo+wnkxVTVNo4k2omcO/Sj77Te6W1PZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kEMfcTgF; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-62f9089b957so1221a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 10:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758822900; x=1759427700; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nbPCHfJ+LLlBruT2Jb9S8w0HTGCja4pN4K+XH7Xc4jg=;
        b=kEMfcTgFw0ltHu13Pg/EWgspDruLGxYnWDotSauAa0ymcDoC7rYhZo2VSJeNOQ5kIQ
         LlC2q+nwS+9KGnZpJVaNQDUa5832bEfCI/mi9112eUGc0wW5DbYId0q9ihqqk5qXK5ns
         2xOSrdVZL/A0nO/8W0RjjpEBhp4Bvpfqu1HzqWbgQbZl8rO5CsjN/FU+N1ARWupbKEyN
         oARaFG6DQtcEgjtGAaFLpGeybf042tOS7gKYOK5i2PGr6gVS8OeRJ6o2VILm4rqDa1VX
         oBuTe4LRdbFCPfJ/AFIw29DiwggAIXndAYHwcN6Xy/IDUFgm7iIPkY2Mi9i+GIwzo1jg
         fGVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758822900; x=1759427700;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nbPCHfJ+LLlBruT2Jb9S8w0HTGCja4pN4K+XH7Xc4jg=;
        b=ciVxK8rXauDFhmhuG+KnupbaNCfbhK8rk03S9U1kdLFhlDiZcSayv1gctjSWyHUHkP
         3rQ8ll/7x2gVKbD4+OcEusZ77GWrsUuTodyXwxD8dD+GVJYOsvUWej2QQFcsO10tDirf
         u4C6GuU2gUzBOnx/j2+iL8J+m163yNR9vWDhBGusC5fUX0HH/ADN6KERGU0ICI/owltr
         7DPzWBDYdTZWI72Xyy+WSarUqZMeC7R6+AQxDGsRI53wwnTpAgJqtTCkeg6XwS/fyyxk
         CBX8ilBp4t2GSIHq5YpPMOyfKb8uAqGLnrGqsoNqtsRCtgA+50mvroLsSiUlQaaWMfR0
         TzTA==
X-Forwarded-Encrypted: i=1; AJvYcCViy8lFp40O5JMikw65VdJJcS5udgym9KBtKCuW/MgMINc053ppPLG8burrzZ3aQNSORgdsh8eWG5AhvdE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5T0W8bems5qxfJjtG7EPK3Fvd+Kgrd/EjrsplFYHZopxp2g96
	3G8EZHoSv0HVRq1MWmcIrKKeXHiFOpdVgAbzPCaZ0oocdCJIIA3qjEmS65+fiJ0/oApgACGzhmX
	XCmSjYqmC9JH2R11vD3j0X9RBP1yBnBoPXUM9Mjii
X-Gm-Gg: ASbGncseuhotBhRVhkLNSjTHNeEAP0MZtiyi1yVCLJSWT04upPBJIv1WGsMNlcgf868
	AhZMg/3wYN2q60xxOp7atnC8r9JeRSHf5jdnY6ey2+e2ck8sAqR4v7ZVCrkN6HTht6A9z2BgKLn
	hwZDUJZ+4nabQ+MiW/mlTrgPFwHylZhsyouZ18TuSG0M5u1Fh2dlSn6cu5T/f1H3jWXv2s2GeJ8
	ui7SWdTa9DTJQ==
X-Google-Smtp-Source: AGHT+IGtWrFCQ7mHkGVN8nL9J3bywwrPeWB4MitTqY1IKv2q0yoGPb264XUgeOr7c8WslC5vIz11r/IeITZc/CAugP4=
X-Received: by 2002:a05:6402:703:b0:62f:cb1a:5c43 with SMTP id
 4fb4d7f45d1cf-634b63b6099mr7603a12.1.1758822900121; Thu, 25 Sep 2025 10:55:00
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250924-vmscape-bhb-v1-0-da51f0e1934d@linux.intel.com> <20250924-vmscape-bhb-v1-1-da51f0e1934d@linux.intel.com>
In-Reply-To: <20250924-vmscape-bhb-v1-1-da51f0e1934d@linux.intel.com>
From: Jim Mattson <jmattson@google.com>
Date: Thu, 25 Sep 2025 10:54:48 -0700
X-Gm-Features: AS18NWC5T26-RT6cIjgQmdeDLluP8Y_82To_ggt5vVuXe4Ii6oC9sC1vUudwIWo
Message-ID: <CALMp9eRcDZoRza7pkCx_fmYZ9UZDGRAXQ_0QP=v+pMMBKx4gfg@mail.gmail.com>
Subject: Re: [PATCH 1/2] x86/bhi: Add BHB clearing for CPUs with larger branch history
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	David Kaplan <david.kaplan@amd.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Asit Mallick <asit.k.mallick@intel.com>, Tao Zhang <tao1.zhang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 24, 2025 at 8:09=E2=80=AFPM Pawan Gupta
<pawan.kumar.gupta@linux.intel.com> wrote:
>
> Add a version of clear_bhb_loop() that works on CPUs with larger branch
> history table such as Alder Lake and newer. This could serve as a cheaper
> alternative to IBPB mitigation for VMSCAPE.

Yay!

Can we also use this longer loop as a BHI mitigation on (virtual)
processors with larger branch history tables that don't support
BHI_DIS_S? Today, we just use the short BHB clearing loop and call it
good.

