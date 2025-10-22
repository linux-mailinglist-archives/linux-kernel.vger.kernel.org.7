Return-Path: <linux-kernel+bounces-864028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D4358BF9C2A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 04:45:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 990654E3661
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 02:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E08E8221577;
	Wed, 22 Oct 2025 02:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HPaFsug9"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9688F15CD7E
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 02:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761101127; cv=none; b=nI1NOPLqIIud/FqGZLq82OQJistVmeb4AhGl4cH9jUd1F38cEptowsSoUivdnpF3OoRZ8ehJsTYN6MNX6gcANZNsKDUYssCZ+QkVlw2z7epza4s0qHjoaSTPllwTd5rg+uSOMSy+IgrySgyxNBrUzaEK+WdrgAgJYw7xx6H3roQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761101127; c=relaxed/simple;
	bh=eAcIJAMH8RyaOLUFKIfGMYGdTUyHv9MGn07YWGY72Yc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=W1dYeExuzUOmsNqJNotjmLifz/JLrc9ZSeuuxWxHYoBfu+PdKK4JyzWmUkNeV5qlLSK61j6W1ouBidx3fEANf9KIWN0eKPZkiaVIf9FTKqBub9d7FKVmxrjSNXnqBDOci39YDfpBFzigZLezbIuciekJI2jnBlmnMJ06H88HcA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HPaFsug9; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b3b27b50090so1163462566b.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 19:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761101124; x=1761705924; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Lq2jjLsl5/bNBz+EC4uaN0bKVsmnxh0AOoBuKPfAEzY=;
        b=HPaFsug9UpJ4B3490WAtRKV6sy+mIZscgDf9EzvH8ZDuStHM4gdXZuPHbbGvjSho4z
         E+lKZdLPqIuqhWIYnp4W0q00OXl8B1x8KZyXkQatNHI6x2lNKQDMAaVND8gUPa7RinYF
         Zj9Abr8DKir+wPiCaqTTaPgN2Nm5MTnuGTH1wr5fcGsaI9somN4rWQqvt9O2U7Ikpd8N
         Amqdnqnr7s1X+SsmkgabOLSz4IHLVhFvcOUv06mYVBjuneQh5mYWG3/r/iAOojFURdEY
         uMdZsQA++e34N548hbb+EPlktUzXvAVgtzjpWeJDT6lMygMDDBwcDXCxe5XGOLxYtYdt
         noqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761101124; x=1761705924;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Lq2jjLsl5/bNBz+EC4uaN0bKVsmnxh0AOoBuKPfAEzY=;
        b=FIpmMk1oj5VAcYIPDaQriefxUeUS+w9e4bla8gmpPHymhf12YOc0BxtCFBKwMJbGMF
         h5chqKX157zAjjBaeN0TvN6ISSbVANRXNhaIDZ7yJrYRo1Ydh9VeIRRzKsRt217G3JfX
         Y7JXlgpX3tfOcuvlnXysZJlCx1j/0U5eFKrp55lcIn9/ykNS+tZY4lgkPtjTgDuK2K5H
         r3jEs1kapIujJv0yebqRtjH1gmCKSCb7oUWGBa0RfMPI/AAElig2y7fBPCFVynXPcot8
         oUONKzjlEgCrEJ0HwXHDGp7UsWPsdvocwvkRyykCNkcajRy8ZrBq7NwefDKu2wsgAeba
         v5Gg==
X-Gm-Message-State: AOJu0YzLmQQqZDoYhIUOBr42f09MieG1/5pmZte0IlpTqHwBjbGdYWKF
	3qLQZnSS6Jkycbtf8s3cI2Vu9q93/RsXONoAo/JWgJYe7HBDJgiPehK2ljh8Ek8lor0yV9fPMZf
	psBsa8bC/oX/pO5tKsoCpjqQg5FUeVr3/mPABu/0=
X-Gm-Gg: ASbGncu1GsViAFWko261RyQolUAyxbsoVN2pq77Zw28p0GH/Z6ptRyqTaJttsvhv2AL
	2heWjFJB6xwEpU5Fe1XRXpgS4/5dFdxKkKD/8ife9O8nVVgJzfDU1eXx1bW3ycNYSATs3AjU7wc
	SAJQswd6TSXCsuKXaBPc5NtlbRIXCfIltcbZdLIY6BUpOp6mVEDY6/n9fv1qp7wYMhLz9Vt9oO6
	bC34wz3f+li0UjtmgZRrtnmFVzUHnHovsKdyAppKcJxGyC4aK8BCx4GYbPDuPE=
X-Google-Smtp-Source: AGHT+IFzqNo4QzZ1WnPmf2YSkO/3brp2YxIg4GKpGj44en2ic6JhjtUg3luPUNaA3+TTCkgHSJO+n/jbZzZ4eOcucxc=
X-Received: by 2002:a17:907:3f17:b0:b3e:f89e:9840 with SMTP id
 a640c23a62f3a-b6473242102mr2269139866b.20.1761101122985; Tue, 21 Oct 2025
 19:45:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jiaming Zhang <r772577952@gmail.com>
Date: Wed, 22 Oct 2025 10:44:45 +0800
X-Gm-Features: AS18NWCeORSgmXNohzwlr2_oj1p-NbS5QMAaG1LhUMS3O__rfHvgA71-0O9bb5c
Message-ID: <CANypQFbLkw50aXkdjTbYT2S6me5yowReL2asG__MWveMU=vW0g@mail.gmail.com>
Subject: [DISCUSS] Security implications of slab-out-of-bounds Read issue in hfsplus_strcasecmp
To: frank.li@vivo.com, glaubitz@physik.fu-berlin.de, 
	linux-fsdevel@vger.kernel.org, slava@dubeyko.com
Cc: linux-kernel@vger.kernel.org, Jiaming Zhang <r772577952@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi HFS+ maintainers,

I am starting this thread to discuss the security implications of an
issue in the HFS+ filesystem and to seek your suggestions on whether
it should be assigned a CVE.  I discussed this with the CVE team
earlier, and they suggested I seek opinions from the filesystem
maintainers.

The issue is a slab-out-of-bounds read in hfsplus_strcasecmp(), fixed
by commit 42520df65bf6 ("hfsplus: fix slab-out-of-bounds read in
hfsplus_strcasecmp()"). The issue can be triggered by a corrupted
filesystem image. I also tried to use `fsck.hfsplus` to fix the image,
but the fix failed (exiting with code 8), meaning it would not be
auto-mounted.

This phenomenon means that the barrier to issue exploitation is
relatively high, but I believe the issue's impact still warrants a CVE
for the following reason: it involves kernel-level memory corruption.
If a privileged user attempts to mount a specially crafted HFS+ image
manually, this issue can be triggered, leading to a kernel panic and a
system crash.

A reliable, user-triggered kernel Denial of Service (DoS) is generally
considered a security issue worth tracking.

Given this, I would greatly appreciate your suggestions on whether a
CVE should be assigned to this issue. If you agree, I will follow up
with the CVE team to proceed with the assignment process.

Original issue report:
https://lore.kernel.org/all/CANypQFak7_YYBa_zpa8YmoYzekV_f39jvWJ-STudDUTR2-B_3Q@mail.gmail.com/

Thank you for your time and expertise.

Best regards,
Jiaming Zhang

