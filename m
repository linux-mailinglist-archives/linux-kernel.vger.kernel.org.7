Return-Path: <linux-kernel+bounces-761292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF2FEB1F77B
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 02:50:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 916D13ADE8A
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 00:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA20B1C69D;
	Sun, 10 Aug 2025 00:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V+zoD5MO"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB81B660
	for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 00:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754787028; cv=none; b=gXUa7LbaJSZdSiwjDQJxybUrPhUQfCQieL4obQ3/jxy3/PeMmPVvW8kVKg6AwR87rklLFtxLkiBnJItKqcUjw+JbTfZKXG2lF+Ipy1DyOzcq0kY+N+SuJuYXw1DKpPauyYcRyi6HdL29X3oMhMrVk+6yJgdXzZeoZIZSYsKAvnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754787028; c=relaxed/simple;
	bh=Ba4brA2ogJTzPenC9lKFuHTAA7jq25ngaLLV44WtBLU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GQnJERshw4Qgyj5tspIExaHTKRPN1m9+PJtjoPSgdkL86J/kpVywCIRMPSodEP2MIL9quNmAssTNHFaRr10cOw6f/z1bPmpdJqbHELD50ZLjnlvO2yUUFz440fMJ2qIrODlx1DQex7QAizHxWfqW+nt6ap9kzz60EZ6TzsZAL74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V+zoD5MO; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-605b9488c28so5808110a12.2
        for <linux-kernel@vger.kernel.org>; Sat, 09 Aug 2025 17:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754787025; x=1755391825; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ba4brA2ogJTzPenC9lKFuHTAA7jq25ngaLLV44WtBLU=;
        b=V+zoD5MOgJszfcHGTsXQ+mtzcYkr9QiqshIx+8tlMDR31zpDXL8lun309rXAmLDds9
         ryK0HITXCANRCDTaEVm0GKxlFaiuxqAeA0DPnPgh0t7/aX7OWfZv6jwaZMnNYwxiUfjJ
         YyCR6LzDR5xNdZs2hDwhk6T/Jb/vy0ROrh5czfk006pDSQkcSY2MdGCqbrTFSQ/+yTM/
         0EowufgnTPqzBzEwWviX2pIX288/efem6E2pCLW6YQvpU9ABAJNfajSeUmon0meniEQb
         eDkJNSwrux3Jyvr8MlV9SWPJ1+K8BO/jemOsbVrjWmbiY7qpvUWUpNJARBgNfcGJmqA/
         M5JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754787025; x=1755391825;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ba4brA2ogJTzPenC9lKFuHTAA7jq25ngaLLV44WtBLU=;
        b=Uj0tQEWK9r72yynFJpck1+ikNCAO9cmdrD9ltNSn7uEMzNdTcXp9LAR2Nej1P+4bQz
         drdTry0L3IVcOwcAI2cWd9lZaU67Vq2w64XPwNvvWvZcLycQ06IeUQVLtz7tDfZ0uo7r
         HdNVkj2eANijVxt003YMYY40jZ9dhIoyEC3cYkP+kMjJ2+T2I83mka6GIfMdMayz/ScD
         gfYAn9fwAY8GjzxftEazSVT7h3maogDG+o7MIGAY9z10q/yqiMzaUHlCZdC1DpyD91D+
         Yq7OeAKD/rF0o28FJ1xdsemRyFTsQ/p+ZNxJEcUjRTtsMnaRsM64FWLSVzhySeqxvPOX
         w/Og==
X-Gm-Message-State: AOJu0YxbQd58G8E9p8irWohw1LLEmE+1BakO/BIYeMBTjmaOPwdfnijO
	xff14Xrom4/HKx9hLnd7SC0I6V5PQ7hK1nd4YZMttGRwmK0+CmmqyKemLEOueleShIVEFZ8KMPs
	tBv1AiDLtw0bls9KJwwX3rF7ayMnyCGY=
X-Gm-Gg: ASbGncsGagBOxHxYbcizE8dDaIGp743c4ALXtBS++G/+ii91JZAFp8B80gWvd+rycfj
	8/3iGQ0oAfpqgEzQj0gLgsFEfxX9dqqfXRaFI6ogVqO568aBTFnfn2FK+q87P0qKAVMe0IDBVgt
	e+j50aOjqkkjdbUzUPoCCVfwswEiSB46/AfIFqA2aX6WM6kYS4PM58K6fWtv4B30CTYsvb6bVLY
	fT4XHnzMHpz0wJwsB/7q6WvMzRJRNq4l+uCbOA=
X-Google-Smtp-Source: AGHT+IHDFltqqEePRdI3Bk9w4tVxlj7ls6tuYPRjB4eZwmq09Po83xqonA+gu2aSNM54qdtFOZCI0RMAgB3v0vc7Tqw=
X-Received: by 2002:a05:6402:4309:b0:618:1250:ac54 with SMTP id
 4fb4d7f45d1cf-6181250b01cmr1684071a12.21.1754787024967; Sat, 09 Aug 2025
 17:50:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+LcPJ3nAdBmuSBQ0mgzFmUL=ZE5RKkfp_4dQf-ycTiHxH=PXA@mail.gmail.com>
In-Reply-To: <CA+LcPJ3nAdBmuSBQ0mgzFmUL=ZE5RKkfp_4dQf-ycTiHxH=PXA@mail.gmail.com>
From: wajahat iqbal <wajahatiqbal22@gmail.com>
Date: Sun, 10 Aug 2025 05:50:13 +0500
X-Gm-Features: Ac12FXyYW_gewChXiR6nmZL-xdDrshOfCvH_V5M4UMWvr0UnJjaEg4qwPwQkvcY
Message-ID: <CA+LcPJ0YQtbYcyyTniFafMOy-iJY++Od1Qd-Tu8vzK7JaFsOLQ@mail.gmail.com>
Subject: Clarification on SEAM Interface Usage and Patch Scope
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, 
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset="UTF-8"

Hi all,

Thanks for the ongoing review and feedback.

To clarify the question about the SEAM interface and whether this
patch should affect multiple drivers:

I performed a thorough search through the kernel source for the term
SEAMCALL to identify all users of the SEAM interface. Running:

=> grep -R "SEAMCALL" .

from the kernel source root revealed that SEAMCALL is currently only
used within the TDX (Intel Trust Domain Extensions) host-side code,
located primarily under:

arch/x86/virt/vmx/tdx/

No other drivers or subsystems in the drivers/ directory or elsewhere
in the kernel tree appear to use this interface.

Therefore, this patch targets the sole existing in-tree consumer of
the SEAM interface. If other uses appear in the future, I am open to
updating them accordingly or submitting follow-up patches.

I will also resend this reply including all previous To: and Cc:
recipients and format it as plain text with inline replies, as
requested.

Please let me know if you have further questions or concerns.

Best regards,
Wajahat Iqbal.

