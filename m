Return-Path: <linux-kernel+bounces-801066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B891B43F74
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 16:46:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33597A44CC5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 14:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D29C0312808;
	Thu,  4 Sep 2025 14:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mWXMFSc+"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5789B3126C5
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 14:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756996847; cv=none; b=H7YiX9oeA+TEdxGm8jB/wGXM5F8MIMT7JBbWZ32UgBXeMUi/IxSy6zFbzaiNtY1OG0VT/tTLSTuBRO8vz1ZFmM47YWSsZLqXxKfbcg8QtQdRVvFaynwOKr51YKyw5Razwh9iX7gM9P+0bwZWJ6781aCG1sXsOuE3XmspAf+ebqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756996847; c=relaxed/simple;
	bh=zqvvSo0TXB3FkNDe2btSaJpcFhEudIv8pOiajsXr31s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JRAFeMKSIbO0bD9f3aQiH6416jgPlIuJdPSXZ1bHhgK464Tvf4+0b6/d4y6fzoWI+kdjne4VSH3ciKKzl3lR5hVPsTSpLh3eFH9UxosM+D5OxEtX+Sdvs/a1vEduh/0KnTKzCZtELVKO05WO58xoFq49NpV2MnQXsAjTm/NCoAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mWXMFSc+; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b476c67c5easo745593a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 07:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756996843; x=1757601643; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=X1KqFT7E4GyG/SOTOK0WZOyrHnlFYC93qFLmJ/jKTrg=;
        b=mWXMFSc+nv912MUTbZw1rhQ3veUWkL1DVD9UaR10cg6KWPuP4PREbxcqQ8OtlrcD3x
         Hgn6hrjGwB4KxUm7MclsT880AgpZCxzclbMSiJxIUvO4261gNkKFUO621cCVMEzHdNwb
         tM1Gi5Cxcx79yqNQqYMFLQH5i5hLz2Y9+ArBcEHQzhQGODRcV8WOH/27SMODzDuiS0en
         23DhvjlPu+Jmbld5NfhXB7sgqnSjpPRXurwNrH7OFUHQsUZjnhjCkvzLjHoH2SZwqqnE
         elfc3eY434CEv4iYMjGuIv7/7WTOYYAu9QCWPbDvLvkTTtMmwJt/iSGNljBn0PlmVNNA
         BCUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756996843; x=1757601643;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X1KqFT7E4GyG/SOTOK0WZOyrHnlFYC93qFLmJ/jKTrg=;
        b=qbzCIF9uUJNJy4Z2ByvihV6a+Wk2X0Qtp9NjxYoCMGFRZLRBI0Pb67i9pnEHCLUP+i
         mNwbcombFFL496CZOik0bFkhM40bBpUUTzcZVKBP9zMNwJ8s/spj18Q4wiApITXLyVLw
         7aJM7lKGSr9DZi3xkbCM1T7fs+GLC1NFUpNKSjwsVfynyuAGSZdjzKXiDCP3NHNF7X6f
         Pv4D7DJ1yOss2R3SZ535GrSk3f2HZ1KQMI5JN5oTSW6eIxDrmvwJca1RKiQExUSeG1lf
         pi0/5dyvZNF/sDxrWmm1UCclIyoxODZZBGLcoYrGYOBeFIcSeyxfkZsRD0RP/NqaI2AW
         u/Aw==
X-Forwarded-Encrypted: i=1; AJvYcCX4Rl5EeFmJ/PWEOAdFrPl15LAc97up/w68w1t95mJ8R/XpGW/iuserH/OS9pIwUsRR/TV+HOZnopzS2KI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+dHVrz0nxhjVbDkOBkwY73ziSHdGnh4gfC7+HwC9PYIej8hHy
	TEm/fFhbtkeppq+GxQzMsKeptIZS27tKLnYsp0YJ78U9NCHemOWbmePHupac3DmMo1/rfARK+Vq
	T20OaYbGNEArcifmUvZaO0QgP5ZheW+RP615ZlZrNTg==
X-Gm-Gg: ASbGncvdyeX0yqlym4AcwOpzbZQYl8019dVHYWg0zexSHDBx9ZF6vUrxxmzFX7FrgFy
	vWWOU8e6vb2/4jLQUbF8WZ+YVxupEEfpMNYJcLsXXqoSAPurfcC1aMAqnrHoJFOTysQEHVg7v76
	hKTx9wK5pM2O235I4BXmS/zBDl9+Wyhr60wOpJm+6rJf07gCrj019UXPz0wshiueyn4a0g0BGne
	FSMO0CF8Q==
X-Google-Smtp-Source: AGHT+IEivb/Ke5Y/N7ysCpClj2ior/OnU7zMvr6vUkDewWL8kJYVeAtE6EcqAr1FQN0FeRMUaS9AlSy/Yr3XQteFNac=
X-Received: by 2002:a17:902:f642:b0:234:986c:66cf with SMTP id
 d9443c01a7336-24944ac387bmr243602675ad.16.1756996843341; Thu, 04 Sep 2025
 07:40:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902174351.2457022-1-raymond.mao@linaro.org> <aLkAYitpWxWx131p@zatzit>
In-Reply-To: <aLkAYitpWxWx131p@zatzit>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Thu, 4 Sep 2025 10:40:31 -0400
X-Gm-Features: Ac12FXxZk0dlcdKvvKrNgUzQLsHOKQcnK2_VUsguVb8gKm4aMWXeyWYtaEDYZ3I
Message-ID: <CAEfUkULwQxJ-EKT7bQ8+hkH+_xO8esThnL2P_Rc-32tHyMdA1A@mail.gmail.com>
Subject: Re: [PATCH v2] docs: devicetree: overlay-notes: recommend top-level
 compatible in DTSO
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linux-doc@vger.kernel.org, devicetree-spec@vger.kernel.org, 
	devicetree@vger.kernel.org, ilias.apalodimas@linaro.org, 
	Conor Dooley <conor.dooley@microchip.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi David,

On Wed, 3 Sept 2025 at 22:58, David Gibson <david@gibson.dropbear.id.au> wrote:
>
> On Tue, Sep 02, 2025 at 10:43:50AM -0700, Raymond Mao wrote:
> > When managing multiple base device trees and overlays in a structured
> > way (e.g. bundled in firmware or tools), it is helpful to identify the
> > intended target base DT for each overlay, which can be done via a
> > top-level compatible string in the overlay.
> >
> > This provides a way to identify which overlays should be applied once the
> > DT is selected for the case when a device have a common firmware binary
> > which only differs on the DT and overlays.
> >
> > This patch updates the document with a note and example for this
> > practice.
> > For more information on this firmware requirement, please see [1].
> >
> > [1] https://github.com/FirmwareHandoff/firmware_handoff/pull/74
>
> I think this idea is probably useful enough to be a good idea anyway.
> However, note that it leans in to an existing ugliness of the overlay format:
>
> Overlay dtbs kind of mix "in band" information - the actual new
> content for the tree - with "out of band" information - how to apply
> the overlay itself.  Whether a given property is data or metadata is
> determined by it's place in the tree in a moderately complex and not
> super obvious way.
>
> About the clearest divide that exists is that generally the root and
> first-level subnodes are information only for overlay application,
> everything under that is data to be applied to the tree.  This all
> tends to have names that would be unlikely (though not strictly
> impossible) in a fully applied tree.
>
> Putting 'compatible' at the root of the overlay is putting something
> that looks very much like a regular device tree property in a place
> and with a function that's purely about applying / validating the
> overlay itself.
>

Since all information at the root of an overlay is considered as
metadata (out-of-band),
If you think 'compatible' is confused, I can change it to
'overlay-compatible' - which should be 'unlikely' to exist in a full
tree.

Regards,
Raymond

> > Suggested-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > Acked-by: Conor Dooley <conor.dooley@microchip.com>
> > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> > ---
> > Changes in v2:
> > - Updated commit message.
> >
> >  Documentation/devicetree/overlay-notes.rst | 28 ++++++++++++++++++++++
> >  1 file changed, 28 insertions(+)
> >
> > diff --git a/Documentation/devicetree/overlay-notes.rst b/Documentation/devicetree/overlay-notes.rst
> > index 35e79242af9a..30b142d1b2ee 100644
> > --- a/Documentation/devicetree/overlay-notes.rst
> > +++ b/Documentation/devicetree/overlay-notes.rst
> > @@ -103,6 +103,34 @@ The above bar.dtso example modified to use target path syntax is::
> >      ---- bar.dtso --------------------------------------------------------------
> >
> >
> > +Overlay identification
> > +----------------------
> > +
> > +When managing overlays dynamically or bundling multiple base device trees
> > +and overlays in a single system (e.g., in firmware, initramfs, or user-space
> > +tools), it becomes important to associate each overlay with its intended
> > +target base DT.
> > +
> > +To support this, overlays should include the top-level compatible string
> > +from its base DT.
> > +This enables higher-level software or firmware to identify which base DT
> > +an overlay is compatible with and apply it accordingly.
> > +
> > +Example usage::
> > +
> > +    ---- bar.dtso - overlay with top-level compatible string -------------------
> > +     /dts-v1/;
> > +     /plugin/;
> > +     compatible = "corp,foo";
>
> This is not valid dts syntax.  Properties must be within a node.
>
> > +
> > +     ...
> > +    ---- bar.dtso --------------------------------------------------------------
> > +
> > +This top-level compatible string is not required by the kernel overlay
> > +mechanism itself, but it is strongly recommended for managing overlays in
> > +scalable systems.
> > +
> > +
> >  Overlay in-kernel API
> >  --------------------------------
> >
> > --
> > 2.25.1
> >
> >
>
> --
> David Gibson (he or they)       | I'll have my music baroque, and my code
> david AT gibson.dropbear.id.au  | minimalist, thank you, not the other way
>                                 | around.
> http://www.ozlabs.org/~dgibson

