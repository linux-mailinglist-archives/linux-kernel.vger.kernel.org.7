Return-Path: <linux-kernel+bounces-727333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C059B018A4
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 11:47:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FE50762F63
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 09:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A93B27BF7C;
	Fri, 11 Jul 2025 09:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bysfg/b+"
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51FA427C854;
	Fri, 11 Jul 2025 09:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752227203; cv=none; b=BlnkEiDAbflC8C/IjbwHiM9fBzXYOVplvVOosADaR5fzFFOkPh83sozqMu+tlG6k2KDRMOXIvbmwAuiwuveJKTgKj50v3vVzwG8eWWXcAZf0CRRQV9tCgUv/H4CrzrAqhVIP3ceuAin682jhN0N/Kmw7W4EizmOQZeP8fpmIiFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752227203; c=relaxed/simple;
	bh=nnRrQFs+x5dUi8UbtTL0Q1jPf5V80eBXTe9LNjC4hgQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IWDl6s87+vTsKUyjYcJZ5mJcLQ6eY/eoK2gn97P6L7r0XcuzYbOVjUhhqtnVIQwn7SbQ5M6cvqXHLT+s3oL/Dz037yJ8RJUBZqBaocQvCgBVC3OLeO3muzfeBapZfpGcJ9HzxwAOq99R1jr9NB3dY98FYySzLgUa5RRWKF1O1rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bysfg/b+; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e8b62d09908so1729853276.2;
        Fri, 11 Jul 2025 02:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752227201; x=1752832001; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nnRrQFs+x5dUi8UbtTL0Q1jPf5V80eBXTe9LNjC4hgQ=;
        b=Bysfg/b+p8VDU70wFhU9O6Bwk5SPvkNWRMVlwO/e0jxbYiXeKh6A4sWQEk906Hu6fm
         9084paFVUYSjs5PH6HV9wfSuu0fx1Dj+gKY/g8bDO7Gt45P8bY2BGhYOCJm/fCql/ieI
         eWZV+fVzW4eL9nEqolWO/0bj9nZiy62HTojdgAJGYnbNxIjmwlkOx/l5t9pxLbu8eB+f
         UIW/ASpPAcifIOA3Ni1caPZGuxGU1Jwk0naOjny1Hu1ts7sUszb7J6w99R8hbUUlhdRg
         A8+ofY6voy/BYqDgtkEWyABmmUFo0liddtiadGJ725gFw+XN6r6AckTAiOKwc640hQSz
         Yn/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752227201; x=1752832001;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nnRrQFs+x5dUi8UbtTL0Q1jPf5V80eBXTe9LNjC4hgQ=;
        b=aRbGUTkw8B59FXd6oIkvArDHp7cs4UBiHfd38AFJfv5hpuK7Uw7XIoMyh4IYvm5gF0
         vTqRx6P7GP+BXYFPBCZvjYQ3KBMMz/QkObl9TU9yhfbNTaBsgD4Gp5CL5RwUpuNqY9tp
         lQAzxO/anHaavHCIPzhOaqYgbeO/Pgj1QJyDI8yFfQyi+H/E0Ib+zq7yWd6I2dfCMILp
         bhV3v7iMgRUHBub9+s5wpEcR46hYxha2ogtiSzhYTDov+t3DWEY4LTHpHLJNjq1QMjqm
         siyW0WQGcM7PwFBwUkpGLYoflEVdghHLVpcYxo32eyyfWuu4isCUziG8kYddPMEGbxkf
         O1Sw==
X-Forwarded-Encrypted: i=1; AJvYcCWNHo4TAPqB+mZBXC9XhlfLmXm+OBQDtuzsoPdlU3KOWGD9YfVMMI8VjENDyL5hViM9eobqXf7V2Zl4zN8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz10UkqRWT/9XIuH0mntlqO7u1XC0XvTVlKaMAWc/e1Ekeqcny
	9s7uE5SgHB1D+T0YMdoXI3QfrHVVPrBzfLvb7b8+Sg5fKwhQnCi4l0ckXaFwEnVvZBGNbTakhVZ
	qfzowzAILQXuiMEeLOcTMKHNVAKUJpq0=
X-Gm-Gg: ASbGncts9ZuE8zLzP8eRhkK0gQmgqv+BYx+y5t7a5ObdcHsu/gmgC2nn7p9hn7V0Lm+
	WyJdiVK/aYp+1Luim8aWgPjG4pgq0uw9SJj79dN2rXc33+xLjWlHwUO+Wzf6P7OR0pz3w5yOzea
	ieU4lv+tTNlPIzp057JmbHKEXRz8/d4DeOI6akp4oDPcc1jHyHqZbl7KZ4qTuTeqaSoQngZfgwF
	wMZcA==
X-Google-Smtp-Source: AGHT+IG/hCWDwgsYUDxUNG/+JyruvcE1QSCcLnMNfeS9TcPz1j9SDBIOOE1J42zfnJmRJiePbS6ONLBHsY8GJt83mag=
X-Received: by 2002:a05:690c:f06:b0:70e:923:2173 with SMTP id
 00721157ae682-717d7861456mr32734437b3.5.1752227201280; Fri, 11 Jul 2025
 02:46:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250710162737.49679-1-stefano.radaelli21@gmail.com>
 <20250710162737.49679-3-stefano.radaelli21@gmail.com> <8b03b9d3-60f3-40de-af23-f943d3e2c9bc@ti.com>
In-Reply-To: <8b03b9d3-60f3-40de-af23-f943d3e2c9bc@ti.com>
From: Stefano Radaelli <stefano.radaelli21@gmail.com>
Date: Fri, 11 Jul 2025 11:46:25 +0200
X-Gm-Features: Ac12FXwotqlTlexaghXcjeDsMDeOuHQ9_RnJ0m5EzLgVnZ-6_GlqIHBcx29d-NQ
Message-ID: <CAK+owojqU3ubiynR+9F8rjMNRLDCZKVRPuKk1iYB7CZEUzJ1Qw@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] arm64: dts: ti: Add support for Variscite VAR-SOM-AM62P
To: Andrew Davis <afd@ti.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 11, 2025 at 12:34=E2=80=AFAM Andrew Davis <afd@ti.com> wrote:
>
> Why enable this interface without a codec to go with it? Looks like this
> SOM has a WM8904. That could be modeled here also, or else maybe just lea=
ve
> this interface node disabled until you can add that support.
>

Hi Andrew,

Thank you for your correction.
You are absolutely right, the SOM has a WM8904 codec mounted, but we are
planning to add support for it in the future due to some customizations
that we need to make to the codec driver.

So I will keep the MCASP peripheral disabled until we add the codec support=
.

Best regards,
Stefano

