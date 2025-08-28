Return-Path: <linux-kernel+bounces-790656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EBD1B3AB6C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 22:16:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55EE0561600
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 20:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD73F299927;
	Thu, 28 Aug 2025 20:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xCbzf5//"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A103B283682
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 20:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756412169; cv=none; b=hnjOfTTfPatAxQs7J0cJJPxoL1ljMkCD4IiGan4UPCIAqPDp1stnMm2DC5nCJD/UQXm0W6Ds05cSVcVx4d6VWMqZGYBwaxlH4Q1+tWLUcWI4JmS/xk49rMVYzQ/BgOAE53aetzER3Xvfa1Ubtrz51/3cy0JwNvYi5NZ3DZzaveI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756412169; c=relaxed/simple;
	bh=vYppXqER/DCNJFvbYy+Ni7lXBK1NBNsBNRIYw1sT/JU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tj9vITdHIv7KYIEtFKYCC2NNKSJKIgdrEykpnpST7t5k8MIEPraYceXDEtTdMd4YigvIq5EVAijEISg6oMKrPoi/HHVZhjHQ4W4k4J41g5h2kwJlm1Xt8em8ipt+0zBpI/e4PlpOdXMEAs1YoIlNHzdicrfEinTn3Ji/IigIWog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xCbzf5//; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7722bdaf7acso43455b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 13:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756412167; x=1757016967; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=okAQ+mx+KLt04Z1F7gpiL/T/1yahbyN1f7pe43tk2A8=;
        b=xCbzf5//o2cWw/f8tpiyk+4fxp/WhQZhWnZXZTV/Pg0CfWn9o4SIgF3dKQwGpE8Xd7
         kn+KzXXHE6jdo34a3uRz96K8wdNaaWKgrv46XD7jq4JPGlTE4k925bkTfsPXQk4ayJB5
         YnQvlL3sqDnrBgepMpkIV6CPZM9Rg6nh2suJVUwKiGQCs0NHGBLVYwIaN9JX2GQdlHfX
         cxvB58eAEP7277nEWFQXd+xO6uwLL9LQ2az1ramQkUBwvnvcxeyeGzFs2IPEjIAjMmwW
         dShniV5jzyoyqmFrE0ftI7x7mhDEpx5Ck8Vt8eup2QhGY4ve8uQs24WUIPAaddfxhLiu
         cs0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756412167; x=1757016967;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=okAQ+mx+KLt04Z1F7gpiL/T/1yahbyN1f7pe43tk2A8=;
        b=N4xBYc/NvygUFVtPsk8JPUKW/o4E6K0yeyK6FTLOtrXcdB3+YNGGhcSKLPxNRoEiMh
         rmOYEVGns2/LQmCozd8ix/oZlgxJ3HEC9h9N+M7EppLYQSAsP/vi6wPhUhAoNRBiO0KI
         aShfM5h3BIuMJvzd04UwwJONRCkAm8McHOFz+cLFdQt4BLlMPl209TZVhkN8pJbZRe/q
         XMpKxSUxrHxtGodeFIKFVkX36A9q+F7I9MMA/jrRknlgJCpv/9OB5nQI6VpVNfZfrPwg
         nM7dRw4H2zOvxVpq9vmc3G24/0s2j/7/ujddeq6Uwi3fnSVaywlKD+zSmnUixl+X01Z+
         xYXQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3PWYH/yJCtLPtqo0qgAlcprOygBrR46DSL/DQc55LSsLQtwkewdF3VTgoFVoElDN37FkKXToyPKnqZBA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNGP7d4yRa21uhFkOruofgVhunU6bblI+ZDLjpb7zmyXkwgDAN
	9T9E24WnwwQCuY/Zh0ffmZBxp2RRx0YN6llgxpl4ycq31hRmlm6WG7iSccaEsYzJIQK6s4GZmnD
	JxunFIg==
X-Google-Smtp-Source: AGHT+IH6+Zr0Wi6xoSuLJHN2y4B9iFDGNLHQlCZjGWjUYKBYX+uCbFsxoIeZOmCfFS81005iowueAs/hxw0=
X-Received: from pfux27.prod.google.com ([2002:a05:6a00:bdb:b0:772:2a20:b41a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2d85:b0:772:a5c:6eea
 with SMTP id d2e1a72fcca58-7720a5c7183mr10432533b3a.17.1756412166963; Thu, 28
 Aug 2025 13:16:06 -0700 (PDT)
Date: Thu, 28 Aug 2025 13:16:05 -0700
In-Reply-To: <aa1835299cfd79788572a212761d8838c388ed37.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250827000522.4022426-1-seanjc@google.com> <20250827000522.4022426-6-seanjc@google.com>
 <aK7CvEcYXhr/p2wY@yzhao56-desk.sh.intel.com> <aa1835299cfd79788572a212761d8838c388ed37.camel@intel.com>
Message-ID: <aLC5BReucEqmBNTr@google.com>
Subject: Re: [RFC PATCH 05/12] KVM: TDX: Drop superfluous page pinning in
 S-EPT management
From: Sean Christopherson <seanjc@google.com>
To: Rick P Edgecombe <rick.p.edgecombe@intel.com>
Cc: Yan Y Zhao <yan.y.zhao@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"pbonzini@redhat.com" <pbonzini@redhat.com>, Vishal Annapurve <vannapurve@google.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"michael.roth@amd.com" <michael.roth@amd.com>, Ira Weiny <ira.weiny@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 28, 2025, Rick P Edgecombe wrote:
> On Wed, 2025-08-27 at 16:33 +0800, Yan Zhao wrote:
> > On Tue, Aug 26, 2025 at 05:05:15PM -0700, Sean Christopherson wrote:
> > > Don't explicitly pin pages when mapping pages into the S-EPT, guest_m=
emfd
> > > doesn't support page migration in any capacity, i.e. there are no mig=
rate
> > > callbacks because guest_memfd pages *can't* be migrated.=C2=A0 See th=
e WARN in
> > > kvm_gmem_migrate_folio().
> > Hmm, we implemented exactly the same patch at [1], where we explained t=
he
> > potential problems of not holding page refcount, and the explored vario=
us
> > approaches, and related considerations.
> >=20
> > [1] https://lore.kernel.org/all/20250807094241.4523-1-yan.y.zhao@intel.=
com/

Oh, nice!  I'll grab that and massage the changelog to break the hard depen=
dencies
on the rest of the hugepage support.

> Yea, so the outcome of the huge page related discussion was that we shoul=
d look
> at some sort of emergency page reclaim feature for the TDX module to use =
in the
> case of bugs. But in the meantime to move forward without it, using a sol=
ution
> like in this patch.


