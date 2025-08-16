Return-Path: <linux-kernel+bounces-771828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C643AB28BFA
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 10:43:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74FA7AA2E80
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 08:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A6CB23958C;
	Sat, 16 Aug 2025 08:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="bsivWifI"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041341E1E1C
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 08:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755333779; cv=none; b=L5HsnMKcEsNztdwR3EO5+Sxi5se9O2SRGHjPPeMnnXarIbFiHsPx8DXI9nEJoDqLrSoYmVRhNwZUHu5RSxlj0lYcmSvFZUu+1kI7HLTLEc3enS/zMQPBXsftPgBiofinX06BfDlTmbzSQ5zCZEY46JBw+btBVGSQRSHp/DUpP9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755333779; c=relaxed/simple;
	bh=3ebZB6d5kf0LF6Bb0thJiaLSg93MBHI/d3zDqTV3ir4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SAp18WIZHH743BHr7istYfQ7F1Vo8n+soNDgX24+sHMxf2vNo00O+58CCryAbX8W2fAE2OwCyOrfB3wIYLp9ORjdji8GKG5nV32Ftg5kgbSUprmm5Y1V/+sGRCp+QrXU3BP60LJqGY/cqOlPzkLT8eKiNfXaEyhDL6Qjtk6xjK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=bsivWifI; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 8ACB640E0185;
	Sat, 16 Aug 2025 08:42:53 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id g-Crhxl6tMrp; Sat, 16 Aug 2025 08:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1755333769; bh=z1M6qNWqkzTFCUx4c3jvZhlqSp1J5Tj0Ijim/ZtAnwI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bsivWifI4Pij0PtQyi0mdxKADZFc5cp+MkkTJefzQnRZA4ovaZbk7s7pAgQrXopwS
	 mkpUirRQDEHlemnDbGuDA0h+y5OZxR3voPxvp/Ax2U9nmdRgnZlPnbPbydV+DQPSrV
	 lLMhvYzKZ3Qn3SbGCRlk1tulZTxIqJ6BLF8iZlkFwly9MW/xlFil26WfITX2MBEDa3
	 Nqx48S0WxRiNVacqOjPGrpC6q8Aqd/ns2kog+ux6N/1ITE+8rt7wxetj2DCn6ZTXHv
	 m0BJX/AZ5Iw1bz/cfZ0bK7ZfjQ/vxNUofEwwiXq9vYnzd8W8WjUcRd/w2QZSElIVIM
	 YaOybt2BPWT/MpMlxNSNIWlYAYbLBrMq71oRLtRi0pbluptxG/qIb4Qo+9yPoXb6qG
	 96Em7buItzRQZAVNI8Rav6pzTpCSBC/eJxdyYuYs9JOn1fZJOkAxVflina+ZqCi3+s
	 bCc0IfL5TOEWX7cc5BNlHBTp7Wwok3iXyqw5gq+VcAEJ1MX654uO6rw021wKS4Bzrs
	 Kww9bEyBnmI5T0YVu6SfNjrlk/CjqYrWwZ0dsEU9wRTjsRrZm1ZnCs+H+itQ5ls7nh
	 k0XOsr0vRucZlO7wb0cNLuxpEuNvF0xoD5BjCd+pTGMHntWpv/hFmp+bmT7gSkh6gv
	 9fVcdTd7pu8R7r4dAiq1h5Uo=
Received: from zn.tnic (pd953092e.dip0.t-ipconnect.de [217.83.9.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A6EE540E0217;
	Sat, 16 Aug 2025 08:42:42 +0000 (UTC)
Date: Sat, 16 Aug 2025 10:42:18 +0200
From: Borislav Petkov <bp@alien8.de>
To: Sean Christopherson <seanjc@google.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, Libing He <libhe@redhat.com>,
	David Arcari <darcari@redhat.com>
Subject: Re: [PATCH] x86/CPU/AMD: Ignore invalid reset reason value
Message-ID: <20250816084218.GAaKBEaukeGa6b5UBj@fat_crate.local>
References: <20250722165615.GCaH_CryG7kNrAS4O6@renoirsky.local>
 <20250723183426.GA1158000@yaz-khff2.amd.com>
 <27E487FE-EC8D-42AC-B259-F8A18776C802@alien8.de>
 <aIKehTDgP-Nu36ol@google.com>
 <3cc16f7d-c650-43f2-b0ca-d99c427cd69b@amd.com>
 <aIKmeclza-9TDe4U@google.com>
 <20250725065009.GAaIMpIVgAKi0kMBVv@renoirsky.local>
 <aJ-pJvrPyHyPI0qS@google.com>
 <20250815220436.GJaJ-u9FUVTmjyaaua@fat_crate.local>
 <aJ-5XDXp1CxKB_7J@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aJ-5XDXp1CxKB_7J@google.com>

On Fri, Aug 15, 2025 at 03:49:00PM -0700, Sean Christopherson wrote:
> Which is what I'm suggesting here.  If an MMIO load reads back -1u, then
> it's a darn good signal that FCH_PM_S5_RESET_STATUS is either unsupported or
> malfunctioning.  I don't see any reason to drag HYPERVISOR into the mess.

Ok, let's play through how you suggest it:

We do not check HYPERVISOR.

The machine boots on *some* guest and it says:

"x86/amd: Previous system reset reason [0x1]: "power button was pressed for 4 seconds".

If this were:

* a normal KVM guest: the machine is straight lying here. There's no power
button.

* "to improve system stability/uptime, e.g. restart the VM if the kernel
crashes as opposed to rebooting the entire host" - this is basically telling
the guest owner that the *host* got rebooted. I'm not sure you want to tell
that to guest owners if you're a cloud vendor.

* If this guest type is lying: same issue as above.

So, what guarantees that hypervisors will adhere to the spec and DTRT here?

Hell, hypervisors don't even care about that probably because they don't know
yet that this thing exists or if they do, they *definitely* want to return an
error here and not disclose to guest owners why they got rebooted.

So the only thing that is workable here is if all hypervisors either return an
error value we do handle or they implement this properly.

And because I don't trust hypervisors to do this right because, as I said,
there needs to be a concentrated effort to support it - otherwise no one
cares, the *least* we can do here is:

                if (s5_reset_reason_txt[i]) {
                        pr_info("x86/amd: Previous system reset reason [0x%08lx]: %s%s\n",
                                value, s5_reset_reason_txt[i], 
                                (cpu_feature_enabled(X86_FEATURE_HYPERVISOR) ? " - unreliable: running on a HV" : ""));
                }

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

