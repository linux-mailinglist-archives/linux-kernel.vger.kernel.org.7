Return-Path: <linux-kernel+bounces-776441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33D6CB2CD56
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 21:52:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 087C87AD634
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 19:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A048F3101DD;
	Tue, 19 Aug 2025 19:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MekgsoSn"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7BBE30F80C
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 19:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755633137; cv=none; b=LK5dcue2Au9FdMqJqi6bU5whHtUxQXFjoxSYU/F+1oFV9nOW9GrxfhTxR+3NwBS259dAaXYZ9V+Ez/pqeNdLHcAPDsGA9HrvEVeYRd+NdX83HXbAlb1O7Hbvm++a1N6kK2kPQJa8VzLO4vKQ9bEl068MVETebXPY2N/q3dMn2oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755633137; c=relaxed/simple;
	bh=0sozDLdExk4TXDPAbLlvtjYjRMNIf2zw8zW+AEC0+Vo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bTR/WwZDFSydhEx5CguE9LYUj/VM4viGLnQ7QAftwF8sePnFiPL28Yyx55x2CnXe6otZDHRMX2d70PdaiMbK8YAvHJu7sJo9qY41mDTygT905D8yjRpC00RqQwBE+b/0qi7vN8jq59yplE3X5GvlJ8tjl6/PimAg7DSbKT4Ge7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MekgsoSn; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-242d3be5bdfso40005ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 12:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755633135; x=1756237935; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oh+5SXJ8jwRghKiHuR27o1N7jn63j3LWzKXisi5w8vo=;
        b=MekgsoSnsCsxx0qE0Rygygu4Hjp7XsLreZC1o+h9wSfCI/e+7sSxI6CfU0tHGKTL8R
         1ceVa0U2dULV59eVI9J67yxvy9vt34yh3Abxo80Jq3MbvTJqvjmvfhtcTMtQmr9o8yDd
         sOkAfOZwER62RMme4ZAYu/yMyZJk8jKPN59UPhQ/hoWX6hhI1Z+jp4oX+gl05AgbJVYM
         M8Qm/yTOMRlvdUvna902Pd5hyAVfz1yFii04ZIY018olvfbogpkYR3IA6CDDwB5wgnGD
         nbvTDlIyvBwyPWso72BBmzLqwbLEw8DVVpGzqTusB+BdUhhOPcNPjFE1s2pHir2DNOhO
         dWNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755633135; x=1756237935;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oh+5SXJ8jwRghKiHuR27o1N7jn63j3LWzKXisi5w8vo=;
        b=XG6O2cXbfBa/TAagiGnCSeZRaAcpJBt543O1zjIffiqfshoMl6mJavi7QVZrNhOTCG
         dhb/UPxobatwfMgZqkQ21jNSTZjwPoAKeduISYarjhc78SJ3x/5grOeY58Pbz8aB5aSG
         xELWmtKfpBJrSiAEf7anj6tcFbzxSSZjUYwx0vPiBM0dRGxTCz/3Bn+ZtcPjG2SzGBM8
         TU9CWrXu/cymLIL+5so88ykFnQY0Ofi5+9jSSHpZdLR6WhI7CxiUpYJgSpj/YPJW5s0Y
         SgDM1iPe5xZE9A03hNMV5CdcFu1QMDqUkU8ykEhVXnDxdO7ssgh7cxtdUE+kC/JxTdav
         MjJA==
X-Forwarded-Encrypted: i=1; AJvYcCWdyhANhEQYOYEXfTTzXZnapcu/fDDJHPwFToED5ILcOflicRj4ErfvEMKQxdxf3DnDRHk/ZibnScOtQp0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn7wzu5aVhMWYKZhIIe2J3RO6PkBi4b5YxefsMv1XvrULDZ6P3
	3chmpRCNS7ZwW5XBYd8MI7PhoYfoBb3IMkC9s3nWGGBcFi5VgsFMQ3tbpSigHeKblboagILEaRC
	Ljz5TzmDZ6GYpo/GQDfa2RCtiATYXWlOkdJTQzYo9
X-Gm-Gg: ASbGncvnddp6ggLmTq6jkfzs/Iuwx5J9UWfTnBUkcMrDLzJ1xJkmfvsj/stGxfPYNK7
	NMt0rrWqxwu8HY0OKGtTe6LsPTgmdRSocfF3rsO5c4ZqXYXhaia1IJBTDc7str/MTLhXpoiLcV1
	mtl6HdZko3efu0QJgr6R+JXTDW/45VpfN7c80rg4OkisuMoLLhvYHbNQSnqs6b+EimTHxLckWwS
	IwTtBFVNaEelD31lgAapG0cB6c3AwkfbJ9Xo5AqUTLXLouCzygRtMU=
X-Google-Smtp-Source: AGHT+IEJpI8p7NnvP/c/59FjU/wf9B/5rXjt/otrwieXuwkOUkHzVDMcgSlT+2mX7NEyFWVr6PWEvalh0vkaZ2IjDjE=
X-Received: by 2002:a17:902:f54e:b0:242:abac:2aae with SMTP id
 d9443c01a7336-245ee9394e3mr839915ad.12.1755633134713; Tue, 19 Aug 2025
 12:52:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250819155811.136099-1-adrian.hunter@intel.com> <20250819155811.136099-2-adrian.hunter@intel.com>
In-Reply-To: <20250819155811.136099-2-adrian.hunter@intel.com>
From: Vishal Annapurve <vannapurve@google.com>
Date: Tue, 19 Aug 2025 12:52:03 -0700
X-Gm-Features: Ac12FXysLHdcINRFHicQ-VtnUWBRJdLVcQCFN3WT1zgmca0lszc3C194HxKOgCc
Message-ID: <CAGtprH9PdJDzZb=YwOSpFjgNjn0W2K6KFsJNwuEgCSBZ=9f3vQ@mail.gmail.com>
Subject: Re: [PATCH V7 1/3] x86/tdx: Eliminate duplicate code in tdx_clear_page()
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, pbonzini@redhat.com, seanjc@google.com, 
	Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, x86@kernel.org, H Peter Anvin <hpa@zytor.com>, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, rick.p.edgecombe@intel.com, 
	kas@kernel.org, kai.huang@intel.com, reinette.chatre@intel.com, 
	xiaoyao.li@intel.com, tony.lindgren@linux.intel.com, 
	binbin.wu@linux.intel.com, isaku.yamahata@intel.com, yan.y.zhao@intel.com, 
	chao.gao@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 19, 2025 at 8:58=E2=80=AFAM Adrian Hunter <adrian.hunter@intel.=
com> wrote:
>
> tdx_clear_page() and reset_tdx_pages() duplicate the TDX page clearing
> logic.  Rename reset_tdx_pages() to tdx_quirk_reset_paddr() and create
> tdx_quirk_reset_page() to call tdx_quirk_reset_paddr() and be used in
> place of tdx_clear_page().
>
> The new name reflects that, in fact, the clearing is necessary only for
> hardware with a certain quirk.  That is dealt with in a subsequent patch
> but doing the rename here avoids additional churn.
>
> Note reset_tdx_pages() is slightly different from tdx_clear_page() becaus=
e,
> more appropriately, it uses mb() in place of __mb().  Except when extra
> debugging is enabled (kcsan at present), mb() just calls __mb().
>
> Reviewed-by: Kirill A. Shutemov <kas@kernel.org>
> Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
> Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Acked-by: Kai Huang <kai.huang@intel.com>
> Acked-by: Sean Christopherson <seanjc@google.com>
> Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Acked-by: Vishal Annapurve <vannapurve@google.com>

