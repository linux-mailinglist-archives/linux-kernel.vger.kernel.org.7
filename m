Return-Path: <linux-kernel+bounces-776443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E1A9B2CD58
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 21:53:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 655AA7AAA82
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 19:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10FCF30FF24;
	Tue, 19 Aug 2025 19:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="toOUvPEw"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B4428489E
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 19:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755633188; cv=none; b=YWnJq95lfE23l5CS14EMcMsHz4gFm3gnOVe/9s8W+OfTcvvAeJ8wPczZwYNgP1rvyzwjvp1XIVbKEIvLvEIaZQMQWZTlXkDG3SUivw/TfZ2FQ+D5GSHb6MuVtoTNT2aKR9q/rAUBViAi/cxvdVwpEAIrHx+uccDfFhFp4FhQqZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755633188; c=relaxed/simple;
	bh=JnxEPf0TEltZpl270Q1R4nTGFbvYaUy+hFvUN4loxT0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YPXW9p021S7FCAZ31y6BEXNyCtja2nHq7o9onbB+BNetlnwtYTJwAqCG+tJdjwgHdeXRllfKbOgEWCmwyKnUXwmexZNGT9zLiCV7hy4BNZNgZzkwiISRroqz7RE04uIGRqfrsxoUDvBpw9xLptK1xCJfPGtF/ITJJ7Vx2Kc6eIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=toOUvPEw; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-242d1e947feso51875ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 12:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755633186; x=1756237986; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=er2Ukb2ahIabEGfku52pux0+8CgRuxqD53WzYKTy1kM=;
        b=toOUvPEwuDz3sSM9JDlD4s9uVdFP54EnWtks6eh/R4bximOd9zfoHArVrYqTCaLHt8
         m0idngH8DewEYmvW9vcRgXIl2P767ubttB3YVhoNkfEvjG2eNX7Das2criwEbySB5vII
         iiY3xi/GQk05tdQFkJvCNUphZ17VTNb95es0JbI5vWcdv3TZMGsseHi4pu9GkGVZT4sN
         04fK0O1xKD7LFpDkZFGkPK9unIB1K9ZQoPpGDwuhrFsgXsU5qjFDJ8up8+/IZhhwVCxl
         arfsWuI+FFMEDu8uPWkXBucm12r8uY9LPYIhmxtOwusr0GHDvEAjDM2sP5dhArc9mgIl
         OD6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755633186; x=1756237986;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=er2Ukb2ahIabEGfku52pux0+8CgRuxqD53WzYKTy1kM=;
        b=Dz4cJi3Gq7oFZ+vwUo5CHW1ivCGBbgNnzHSaep05zDTgQbdpS+MYepCpfPROq/zgql
         qKCRzwrMNFwCjQH2RCEEzQTtgmEggb0ZmXiGuyyN+5gIWLUi9+UDAocTYu8mh8sXTvm3
         bJqp76onbx7AlGPBLl762AnXTYPz4JycDWNSUIRoqcKYWeg8U/JhGuZEQ3v2j5IJExzo
         u8j+AZExMSk5jujA33vPXL4Xx4w9haZlcnGMa6PF0mzmozXWpufQrqKYZSfV4lR+atR/
         YRQKAPWdBPtoSCXqXaAz0GOf1tvIfzCI6SJfr066f8EkyPq/ufVJ00wRh9YMicb21eQb
         LrSQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZiBsDZ4ABtB7f5xlS3Bn9Dhvg3GIN9XsP6w/jZ9svBNqK1IoMY3UbQnOvXsqkWyzF2uCGHvqNJxa8V9M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXyHLG7NG/jWmVCGpHHWJNAVuisfLrhfnORXbRYXaPJnPZejkr
	gA1RttJOud+tkOLtRgL/qHQcq5BzTxz4RXPgyASxJ6JZoON85a9weE9jRP3e7h9fSMwWeuUmCcA
	Gx1a2GvslrOuDZeMT1aYyPyBqWo9zyKlAlU82kO5D
X-Gm-Gg: ASbGncvvmeJLojvEeiO5GeoUBjcqZE42B29apgioVmSgZ9PVcRbT02WEVj8Wpgsj6QZ
	sMirqN1XnpRFypNc2nasWX1qQ0KLxHoMwPozMAwxjNR9BgEDLLikMlR08edjjX//Hf/x/PCL9YO
	IitMSSprub2LH6Xm/ddHw7psyt5F26gi6zQJZ/QihXArK0qYYYhXPSlBpOuEB61pxxNQgNDgEAK
	1K/JWz0VP9inDER4XbiWFcvoFAKtb2JvJn8TiXmk8DjvXRN29jjdU0=
X-Google-Smtp-Source: AGHT+IFz9bL0u5jDF4CT/TIBN70iRgmzt7yhWGrdHZGgY7hHAFTzW2uCxBVn/7FRz1cEus2s5daf5jYu2U49bgUukpo=
X-Received: by 2002:a17:902:dac4:b0:240:5c75:4d29 with SMTP id
 d9443c01a7336-245ee6d85bamr947615ad.0.1755633186093; Tue, 19 Aug 2025
 12:53:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250819155811.136099-1-adrian.hunter@intel.com> <20250819155811.136099-3-adrian.hunter@intel.com>
In-Reply-To: <20250819155811.136099-3-adrian.hunter@intel.com>
From: Vishal Annapurve <vannapurve@google.com>
Date: Tue, 19 Aug 2025 12:52:54 -0700
X-Gm-Features: Ac12FXzFs5xLT7p_v-1frrxaLFRvMe-6lrfP9b_-Raz9sQEjbrTaAkx3gEjOq_I
Message-ID: <CAGtprH-pv3ReYZSQiof_2Uu6RT4JNLSHyMuw7AuSpciXML5HoA@mail.gmail.com>
Subject: Re: [PATCH V7 2/3] x86/tdx: Tidy reset_pamt functions
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
> tdx_quirk_reset_paddr() was renamed to reflect that, in fact, the clearin=
g
> is necessary only for hardware with a certain quirk.  That is dealt with =
in
> a subsequent patch.
>
> Rename reset_pamt functions to contain "quirk" to reflect the new
> functionality, and remove the now misleading comment.
>
> Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Acked-by: Kai Huang <kai.huang@intel.com>
> Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Acked-by: Vishal Annapurve <vannapurve@google.com>

