Return-Path: <linux-kernel+bounces-788674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E742B38889
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 19:26:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB0151889928
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 17:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 049DA2D73A9;
	Wed, 27 Aug 2025 17:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pko1IfCp"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B282D6409
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 17:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756315581; cv=none; b=aGh/IdMyDc7PWgxswAbLaCluJrjHNn4utDYdeR9CWZ4ZllOTAOAGAh0Mx+tgB4yRmBfgJou4WT7FzjT4VIZ0B0whBhzofQa8s9rgjtVefAqlBIdU5Ovz23LRmyGwpeO6ZywF0BbQqXB4IhrFpK/ezsEJcSl6vLz8za24UQnJ1dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756315581; c=relaxed/simple;
	bh=m92QUz1VhMSyOszNetqONR33Mmv2yjPyx2FnMM/xhIo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YmS/ySafxC8AHJnmFs7MYNzA8QO0b/kouXdTohIkWG7UPDhWPYlvyY7e9S3c9RZzyVGHt94lFkz5o4UsItihkFRmz11hLIQw34YIx9TNXq6omOKcCiZUPxh0P74omCQKfu5BHSHc+RNixPfstoonMjRF9I1BxbuCV76d8lTTGME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pko1IfCp; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b4c1aefa8b7so103428a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 10:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756315579; x=1756920379; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4zC71Fr5dEaFm5d2WzjHFy75uKfi1gcdKd+IVowOXDs=;
        b=pko1IfCp8fM/XBv+s9zpX+Bixqwd88gNCmJuz/enUhw7d2YEIOtP2cAh8rg8Lfszzm
         UCNiZ1PNIisgx/76xnbWiVbEuxLAm9ZRwKFZUrfDQD/Gr67KDCSrztZHEgfBGDy2dl/F
         Fyb9JlfqSoYiBnqpGudB7FCEWWu1zwkfBxM1xIHhHS2CrQml1nnqFt/BgjWr+Rxm5t/z
         EPWUTTj07ftAb9XRKz0lEAMldOCAOwKrPvY0/ed+Nt4p+tuFLkdvfacpdMD+QZGP7qC8
         c+Uq+L1Q7CNbCas15tCIB26FROf1MrX2vb5lCU5Qm0/gVRtTDt2EpvyUmo0hsh/FoEqy
         Dy8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756315579; x=1756920379;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4zC71Fr5dEaFm5d2WzjHFy75uKfi1gcdKd+IVowOXDs=;
        b=WNGvMg8/G1v+6iAtUnyY+DPIIZ4J7p+AUupiWr1Asv4suQp35rCERJC+qqkIQJYduy
         r8ZVskgG8hTHD3gbdYVSB7JSzDzIs0BUw+8QoqrYu2Ilu/vI5ExCv+l944KovQHLO7wS
         39GosYjTiivQVn5GinI3Uu7Z//u3w3MHfFVaHV/DWbW6PuESgihUoEwJ1AQ8M1/EDOIe
         hjZm7xLfoiDMS21j/V66Y+Hwir9Qu411/6qDmk5/9ryyVIUSahNs1i3WgUqnjna3Tie3
         z5vEciYjkvDPxENHw9YEqf08LqKXF+vcBXt8NY+fRPkIfJaBKsYCReiW8S06YMDokAeS
         7D4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUg3HXseh7UaxGb+u3LqYGDRacc4JcvXIuvgLKIK9i54jjYRqQtXjXDGKKbP8g9kHR/Dt3WgbwkmwEufkY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNsxPsZGwnRPQY/jEII7FLiw7roH/pFK/A0Zy4tt/wMzRwxugX
	PT1DgAhTLexyWWfHmhzyWyduwp04FAMxEk3oSElQGUG8mymPWJoSR8rCVONkwbgJHSKabhfTs/u
	/+q+I1w==
X-Google-Smtp-Source: AGHT+IESDg1LpI1nrcySAHRIbTDAuZOVpz+EhAMxyOIaskvr7KoA6Zvhs2DchP1jwY2+XdFu+UizmDI+Zbc=
X-Received: from pfbkt3.prod.google.com ([2002:a05:6a00:4ba3:b0:771:f274:bc54])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:7495:b0:240:1fb6:d326
 with SMTP id adf61e73a8af0-24340c489demr29235354637.21.1756315579455; Wed, 27
 Aug 2025 10:26:19 -0700 (PDT)
Date: Wed, 27 Aug 2025 10:26:18 -0700
In-Reply-To: <aK7EQH44UOr46Hdx@yzhao56-desk.sh.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250827000522.4022426-1-seanjc@google.com> <20250827000522.4022426-7-seanjc@google.com>
 <aK7EQH44UOr46Hdx@yzhao56-desk.sh.intel.com>
Message-ID: <aK8_un-TyaeXAkgG@google.com>
Subject: Re: [RFC PATCH 06/12] KVM: TDX: Return -EIO, not -EINVAL, on a
 KVM_BUG_ON() condition
From: Sean Christopherson <seanjc@google.com>
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Michael Roth <michael.roth@amd.com>, Ira Weiny <ira.weiny@intel.com>, 
	Vishal Annapurve <vannapurve@google.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, Aug 27, 2025, Yan Zhao wrote:
> On Tue, Aug 26, 2025 at 05:05:16PM -0700, Sean Christopherson wrote:
> > Return -EIO when a KVM_BUG_ON() is tripped, as KVM's ABI is to return -EIO
> > when a VM has been killed due to a KVM bug, not -EINVAL.
> Looks good to me, though currently the "-EIO" will not be returned to userspace
> either. In the fault path, RET_PF_RETRY is returned instead, while in the zap
> paths, void is returned.

Yeah, I suspected as much.  I'll call that out in the changeloge, i.e. that this
is really just for internal consistency.

