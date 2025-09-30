Return-Path: <linux-kernel+bounces-837398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 587A0BAC3C4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 11:17:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1340D3A9BD8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 09:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F2A221FC8;
	Tue, 30 Sep 2025 09:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y7/YmSA8"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD3D1D8A10
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 09:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759223827; cv=none; b=TytjNNDwjEO36intkjIHOHWXsUsklW22aurXwpQCKKomvw/8fjylwWaXZJTGM7zeq2pBK9IVkk8ghUbm3ikU5Wa9ZZa6UGOWO3H52ZuQ8z2WoKfzCvGhLIMgD5TAih+oMYHS2bdDR4ws7W/CPKMumvigomT9R5nw3M7G+JFUO2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759223827; c=relaxed/simple;
	bh=C8Cg/mdMvEeqn4tYaiyZTCeXPJbQSpUX3pWcbQSKvc4=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=Q0m6x+pQir0GXWsYEMdoMVrrJmnQ7/WVv5iYTx1J84ob79IUicyFiYygFoxF0GVfd+uvRWH4sSxY6I1sbYUk76BgzCQn2OWPAsoLZ31zEug5hZT+i0vulXSo4Fpzh99B+iZCaZADtJwM0uXQsc6BrHJOzkeHAJ0F5/7oQ1oIYA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y7/YmSA8; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759223825; x=1790759825;
  h=mime-version:content-transfer-encoding:in-reply-to:
   references:subject:from:cc:to:date:message-id;
  bh=C8Cg/mdMvEeqn4tYaiyZTCeXPJbQSpUX3pWcbQSKvc4=;
  b=Y7/YmSA8MGiUq1aphO5nDNG1qxPX8LWnQrE6zHAO4ujyqNkGc1DnG0Hn
   fVhXdr4+IicdrgVLsK+vJxmQ3wr4669Ci286ELcAKu3VITMmKkmshEHWD
   8LIes5lQ/D0r/VZlUApgGTQCQcuQZbdKYHQ8d588gPvUdLqcDHPEV/lMU
   kSKbsUB72Gg+JG83gjgOLzzPmsRpj0pYi1T7Is19B+jrWINu27VUGuMEn
   Z7NNK3rI3mB1xq3ydfq6F64xEogeWZZgFa6ilDldva4IUe+JKm8t7RVPu
   AzqVHJFh9rjZBNbytTcqYJD3/kx5t4BGAQ3GeCQo7PGcjKI/BDASGVj+e
   Q==;
X-CSE-ConnectionGUID: 7Ev6h1yASAeyup4vaV6+aQ==
X-CSE-MsgGUID: DLFet36fQE6Z+M30Nw4i2w==
X-IronPort-AV: E=McAfee;i="6800,10657,11568"; a="61518884"
X-IronPort-AV: E=Sophos;i="6.18,304,1751266800"; 
   d="scan'208";a="61518884"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2025 02:17:04 -0700
X-CSE-ConnectionGUID: amLqGN/MRZ6HIppG/Vrd5g==
X-CSE-MsgGUID: e79KT6whTIWD6ZWc8522TQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,304,1751266800"; 
   d="scan'208";a="178074674"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.108])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2025 02:17:01 -0700
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAGfirffPy5biFVLtSNEW60UCXa6_=-=NrQbU7iLQ8+BXnFQ=1A@mail.gmail.com>
References: <CAGfirffPy5biFVLtSNEW60UCXa6_=-=NrQbU7iLQ8+BXnFQ=1A@mail.gmail.com>
Subject: Re: BUG: unable to handle kernel NULL pointer dereference in eb_release_vmas
From: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: jani.nikula@linux.intel.com, rodrigo.vivi@intel.com, tursulin@ursulin.net, airlied@gmail.com, simona@ffwll.ch, andi.shyti@linux.intel.com, ville.syrjala@linux.intel.com, nitin.r.gote@intel.com, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, syzkaller@googlegroups.com
To: intel-gfx@lists.freedesktop.org, =?utf-8?b?6rmA6rCV66+8?= <km.kim1503@gmail.com>
Date: Tue, 30 Sep 2025 12:16:58 +0300
Message-ID: <175922381867.30706.10351894191632562572@jlahtine-mobl>
User-Agent: alot/0.12.dev7+g16b50e5f

Hi,

Can you please open a bug as per the instructions in:

https://drm.pages.freedesktop.org/intel-docs/how-to-file-i915-bugs.html

Thanks in advance!

Regards, Joonas

