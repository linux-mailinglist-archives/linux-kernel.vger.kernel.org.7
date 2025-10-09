Return-Path: <linux-kernel+bounces-846509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10AD6BC8340
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 11:09:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C56B13E4D3D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 09:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 216382D593D;
	Thu,  9 Oct 2025 09:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mReH5l+s"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C809D2D4817
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 09:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760000926; cv=none; b=eZSq5BMYM4XSiRUrAIwD57kAkmQEOwHvBjY8X9pT9K4+ulNWke4KVObjxSd0H1Pe31g+uZZNDDaETxHcMgR9Hk6K68kuc8wT6Fi2X2fN8W9/Yz2m4N8FF3pTkB+Srbt1nHTbR6weWoGFkY5EvPMVepMJYrKoz8GEnR2k2ofPQFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760000926; c=relaxed/simple;
	bh=fvep23//chNCFYNAfdSyIgM69wVc23KqWs+OFcZMV3M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BJPYK1HB8+QX5Ol1tZNFO1AQAgAtISsDU1qcNj0CjLq4xNroC/yz+w3IQgKKJ6zcGE7BWN4qksoHbmgpogXVw1ud6yA+/VuNLTD/PN+rb/NjsD+F4RHXAIpagoL7X34jOWrN9JayREeHdpIKW3xR6Y1jqCfX0xecsdH5OdXvFWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mReH5l+s; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760000925; x=1791536925;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=fvep23//chNCFYNAfdSyIgM69wVc23KqWs+OFcZMV3M=;
  b=mReH5l+sLc10Ah8N0Klwok46nfvrW+RB1vwBwYRoCMiVoeCjF+plsobG
   0sle68s03w+H8aInq7o1UXt3CniamFqiLyTqlOIdO5zwri3vOwymxXUtv
   u3UYgw+Axm+IMjuf0A0PNmwJxG5HxcmPYdXZTgKzID6wUloqTVGZzpSss
   z9z0P/f+pkYIduqtkOKk4WfRjEP8pBG5yIZbyaHTokwt8BsY/Q2h/8V9U
   h3QpTcvllm0KfB/6DOjwYdLeZPUmnJnbdb21sMpp7qb7fwMZoyk72XPLk
   UcucGbJGBzKiBkOzjSzpAaWF1oPD5Swmu372yWnvSBfXmyA73RK3EoyM/
   Q==;
X-CSE-ConnectionGUID: kl4J/xpwQ1OB1sQ3fMAU1w==
X-CSE-MsgGUID: lYhhvKdUSOCVb6AbBxYkww==
X-IronPort-AV: E=McAfee;i="6800,10657,11576"; a="87665406"
X-IronPort-AV: E=Sophos;i="6.19,215,1754982000"; 
   d="scan'208";a="87665406"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2025 02:08:44 -0700
X-CSE-ConnectionGUID: R9f6YEemRR2+qcwBj/C+NQ==
X-CSE-MsgGUID: KkKt9yUnTLelgy75V39/Ig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,215,1754982000"; 
   d="scan'208";a="184927120"
Received: from ettammin-desk.ger.corp.intel.com (HELO localhost) ([10.245.246.113])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2025 02:08:39 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: =?utf-8?B?6rmA6rCV66+8?= <km.kim1503@gmail.com>, Andi Shyti
 <andi.shyti@linux.intel.com>
Cc: intel-gfx@lists.freedesktop.org, Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>, rodrigo.vivi@intel.com,
 tursulin@ursulin.net, airlied@gmail.com, simona@ffwll.ch,
 ville.syrjala@linux.intel.com, nitin.r.gote@intel.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 syzkaller@googlegroups.com
Subject: Re: BUG: unable to handle kernel NULL pointer dereference in
 eb_release_vmas
In-Reply-To: <CAGfirfdACPUrW7hxOKXEpaPZ6=Lkwde24CfHov9=75JhXiPApg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <CAGfirffPy5biFVLtSNEW60UCXa6_=-=NrQbU7iLQ8+BXnFQ=1A@mail.gmail.com>
 <175922381867.30706.10351894191632562572@jlahtine-mobl>
 <CAGfirfdDe879wFzABVZkTV7grEimpnc0XrrKpj2SX1w_TLtgNg@mail.gmail.com>
 <aN0X3ck-egLMn_Xy@ashyti-mobl2.lan>
 <CAGfirffg4JzGkwaKTm9fL9Nyud4kBALvfW3Et33ZF60e8cVO1g@mail.gmail.com>
 <CAGfirfdACPUrW7hxOKXEpaPZ6=Lkwde24CfHov9=75JhXiPApg@mail.gmail.com>
Date: Thu, 09 Oct 2025 12:08:36 +0300
Message-ID: <27ca005b5505e66cb51bb4917a71ef44b0afc7c0@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, 07 Oct 2025, =EA=B9=80=EA=B0=95=EB=AF=BC <km.kim1503@gmail.com> wro=
te:
> https://gitlab.freedesktop.org/drm/i915/kernel/-/issues/15062
> <https://l.mailtrack.com/l/a23538b60e872501ef9881ddb3a7e5ffc2cbce55?u=3D1=
2392148>

Please do not send HTML messages in general, and especially not with
tracking links.


Thanks,
Jani.


--=20
Jani Nikula, Intel

