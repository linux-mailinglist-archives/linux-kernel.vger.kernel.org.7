Return-Path: <linux-kernel+bounces-726614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C39B00F46
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 01:09:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C49B35C4C6C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 23:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A44B2BE7A6;
	Thu, 10 Jul 2025 23:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fbhICAJS"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BED029E0E4
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 23:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752188964; cv=none; b=i8NxT7oRotkn1YM3zNvIGpB0okeSsUVIuLa/bndEqxeSRommcxxonDCicTsiqVwrRvnvTNMvIEVYrsXcvv3JF67yCUsBpkqGvwE+enQtTTwRpnVrDPIFKHE4rVyhnZRzc0nuPpdzOZZkboIOABniN8wyG40KsGG0LvuO+hWOOPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752188964; c=relaxed/simple;
	bh=9lxY70yNwaUfxPRmm/LKZgcMGtuSY1GvdoO/acP8ucY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=B2S7Y3OouL7KaNeUTdFAX4JNDUpGKD+F1Qr7epzBS0qJylpjWXLzGisl+50/qsz3GBOc7o9+wRndfhVfwxWdiS69YQhxPmMblDIj4lAlc6trVQNpTmCSYgL6g2sViTXKZSszSW3cOOoIi9Cw1QNAUF5XXkk4Z11sTyaK8JG/2BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fbhICAJS; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b38fdc93c22so563974a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 16:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752188963; x=1752793763; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Xt7t5G8OeVYwSzp5fzQ+a5eZavVGVQjGekilFzhtdwk=;
        b=fbhICAJSPYBT+z70CHdHJIicz7fz6948D5uj44a40rSaUHC/QPjHquG8VQQJZDYp6f
         cpvfiEMpi5i89MC9OhQx0yYv3XF6ej8qwVds3JkjrkQsftuFNbJriaz8b2IP2W2ek4rp
         SPBvSNGxPdWXJ8FuRUfrazvliPAOap4KZqYyb7Rw6roKM86VSYArKv3f4ZyfOGuw5498
         I3r77+xaXtzOf94gIlWBjYC6w0i62xTvbhxUuzOXpoUF5WIyOI3yvT6LrvtHeFBfuyaw
         5xal5QCb6iURnaSynXz8MhSfT2HC0ltyNIkTnmCvW0hVMI7ZFQP3tfbQNgVB1DbgFX5N
         NnFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752188963; x=1752793763;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xt7t5G8OeVYwSzp5fzQ+a5eZavVGVQjGekilFzhtdwk=;
        b=j4gs497SXk9PVJ2sOAyMI/uk1BMxdR6j0KEQZ1P2souaZUpAspSsisALiJaY3XKRdy
         bhYI4OaqcFZMP9L0AWvUviHKVCeQdnHUyC6NQxtaHP9CDWVOG5/mXsf/ajbyuPxARUv4
         1dBqPDO+HIL0WF98OTRLqe9Ztf9ze9c1ThBDrApoUsiVwQ/3zj6ezu6f/I6Iy3YYK/1I
         esc+b61tjCL3h3xTGHX9dJI41tz0qztf8nLbJpWJlLseZF3yEcmHKHD10yK7NVCqtRCy
         yATWS28u6IVErmP2jxi3RVkvE5O0scX12rfGbdxh47tJqBEqM4PBVlpMkEsaJ5bjbxV/
         IwUw==
X-Forwarded-Encrypted: i=1; AJvYcCXyd2A2Uj3JJhMb+qwaWCXu+fj2Chp5C0ySSFty7ekjnyZv2XNdmHsss9JmBPoE1F6cSe542/TAT93ZC7I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3Ob3PP7n3meK8wS8dKn3IsCGK1LSvHZPGBkaukpBtCTHlhWCH
	RO5YUVwAgR88LVyVtxPtL0RBeNjEc7ChwmBwc1VHpR9GV15i6CPIJrz+bPiM97q/y+q+PMYihYS
	H0c0LcA==
X-Google-Smtp-Source: AGHT+IHRG3Qs4CaTcbmVyBLUOQi3Rxi6ZHjB5Dwd9IWOeVhcwM8/7NxYvP5HPsj1sxTpjYfbwhDZxFmR8IU=
X-Received: from pjbqa3.prod.google.com ([2002:a17:90b:4fc3:b0:31c:2fe4:33b3])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:514d:b0:31c:203f:cacd
 with SMTP id 98e67ed59e1d1-31c4f53f721mr446809a91.22.1752188962755; Thu, 10
 Jul 2025 16:09:22 -0700 (PDT)
Date: Thu, 10 Jul 2025 16:08:46 -0700
In-Reply-To: <20250701012536.1281367-1-binbin.wu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250701012536.1281367-1-binbin.wu@linux.intel.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <175218136095.1489449.11699515140849916042.b4-ty@google.com>
Subject: Re: [PATCH next] Documentation: KVM: Fix unexpected unindent warning
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, pbonzini@redhat.com, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Binbin Wu <binbin.wu@linux.intel.com>
Cc: sfr@canb.auug.org.au, rick.p.edgecombe@intel.com, kai.huang@intel.com, 
	adrian.hunter@intel.com, reinette.chatre@intel.com, xiaoyao.li@intel.com, 
	tony.lindgren@intel.com, isaku.yamahata@intel.com, yan.y.zhao@intel.com
Content-Type: text/plain; charset="utf-8"

On Tue, 01 Jul 2025 09:25:36 +0800, Binbin Wu wrote:
> Add proper indentations to bullet list item to resolve the warning:
> "Bullet list ends without a blank line; unexpected unindent."
> 
> Closes:https://lore.kernel.org/kvm/20250623162110.6e2f4241@canb.auug.org.au

Applied to kvm-x86 fixes, thanks!

[1/1] Documentation: KVM: Fix unexpected unindent warning
      https://github.com/kvm-x86/linux/commit/073b3eca08f9

--
https://github.com/kvm-x86/linux/tree/next

