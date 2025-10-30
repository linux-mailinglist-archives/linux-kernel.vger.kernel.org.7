Return-Path: <linux-kernel+bounces-878202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CF9BDC20056
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 13:30:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D857A4EA49B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 12:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20BEB31B830;
	Thu, 30 Oct 2025 12:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GKM4+hre"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06BA33191AC
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 12:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761827383; cv=none; b=e7DATCDwYcQ8Q+lPlKTDix0S0yWrKp8DpxpVBU3YB+7k8cVHS+zILRRVHINVc+t2tsnhB/0i5TLESBWjBg+JmwhCuAmvQ5RA8zz2vbkt2r4B5TcDMzqiaLZhMYiHNNfplqJh3oOoB0SV92Rt71qXkqmmYpnfVTvjPNb0H9gD57Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761827383; c=relaxed/simple;
	bh=6glx9woDpeCvbycK59nFQ0fRq1+1rRnPJVeZNMkmik4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=f0VSmJNp5Rs2BUKjtZPGZi3aSAbVd01q1UXDg8uQIG8Bmd2YLI9uAV0hU0wRtO8mkPuHWbjxfp5tNYBJ6xRe5+48Ys+amBA4nGJ2gm7e/Jb1s2RlELx8F2buE9KcZopAX385DLarv+pLU+NIAiflo7k11vZFJU5NxHrPwHs2iNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GKM4+hre; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-471168953bdso8277415e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 05:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761827380; x=1762432180; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6glx9woDpeCvbycK59nFQ0fRq1+1rRnPJVeZNMkmik4=;
        b=GKM4+hredi7LZ9np2n26q+7HwrErNmIxpbF2BPd0y3qxRV3rENyp8SK9UkdP7xr8Ye
         psaRF5cvB/OZWO8VGRBYEAC6KBGCjZXcapEC9FanT09SoRFyYpATPTCoiXE/FfBTrVzg
         xhQhi7VOEChV1h+ZbHlPO4bJG0mtSGLNVn/+WNvu7tQBMiwNRZQZVqj1/bLShVTJbK5f
         PcPYyl6t7k6hcJWGoYrlTUknMR1Qv57oubrDPIskZ/BKV4kbn3GOUBcwv2YXDYxvxZMK
         8BfWrmKEc3/jNI7P84RqzzMftDQmEfLZop/WQS+/cY/irBZ6AohLUwMfBB9Hn1aZzja6
         lWIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761827380; x=1762432180;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6glx9woDpeCvbycK59nFQ0fRq1+1rRnPJVeZNMkmik4=;
        b=gBKtx3ueDlfdJX+ukbZOtytp62+xxCdNCGiNtEgtJ2qAAWvwX3cTXE8c4Zl4ePozZC
         Y+1MP8jmykFxmEffn3lb1ndlCmLt9lWI3xSR9jirJTDeBG1oQ4dNPlGpKFS1qXbdcMYF
         L1Zgoyfa/7on8hAGREhREecquxgARoTsNn3gp4C9W2C1EfivA2e68JZRi27gZNXEJDXA
         Dw7m2yKCTLQ+aeH+k6fhyFTkGjZzF18N6V7e8I/+6UMAGcWR9NAjaYuMofXhq/3OMdig
         lHN3yeTrkpvhqMEWCScHPjcRBJHyURlvjDNLZxnryqnn1nhCbwNMrYnxIstdm0t05uAF
         Txgw==
X-Gm-Message-State: AOJu0YxOL+M2Fb1b2lXcJCO1ZSU68v6fOiHPKjlBNXOqla4LQBhLxLWs
	PqWcKrdvS2fwuOaVxYBYFIumhBgKOJIla8Se6DA4hcT1OGR85MB5DiDoLsB07NgUT1KX1YNNx/o
	i3aYX4tnmjSiZ8A==
X-Google-Smtp-Source: AGHT+IFJU30jjrRfj2rHmfFH1yC5PvdCbuzWZP+cAv5nh5fYXFv6mQK1AGS8WOMTzYBA7PItmqNim7cIM2VNHg==
X-Received: from wmvx1.prod.google.com ([2002:a05:600d:42e1:b0:477:1681:b2c8])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a7b:ce96:0:b0:471:611:c1e2 with SMTP id 5b1f17b1804b1-4772622261fmr23212855e9.3.1761827380512;
 Thu, 30 Oct 2025 05:29:40 -0700 (PDT)
Date: Thu, 30 Oct 2025 12:29:39 +0000
In-Reply-To: <20251029-verw-vm-v1-2-babf9b961519@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251029-verw-vm-v1-0-babf9b961519@linux.intel.com> <20251029-verw-vm-v1-2-babf9b961519@linux.intel.com>
X-Mailer: aerc 0.21.0
Message-ID: <DDVNOKPKN4II.33NWK6IDYPRFD@google.com>
Subject: Re: [PATCH 2/3] x86/mmio: Rename cpu_buf_vm_clear to cpu_buf_vm_clear_mmio_only
From: Brendan Jackman <jackmanb@google.com>
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, 
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>, 
	"H. Peter Anvin" <hpa@zytor.com>, Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>, 
	Tao Zhang <tao1.zhang@intel.com>, Jim Mattson <jmattson@google.com>, 
	Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="UTF-8"

On Wed Oct 29, 2025 at 9:26 PM UTC, Pawan Gupta wrote:
> cpu_buf_vm_clear static key is only used by the MMIO Stale Data mitigation.
> Rename it to avoid mixing it up with X86_FEATURE_CLEAR_CPU_BUF_VM.
>
> Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>

(except the build issue)

Reviewed-by: Brendan Jackman <jackmanb@google.com>

