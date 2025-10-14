Return-Path: <linux-kernel+bounces-853055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B06BDA8C1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 18:02:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1721618957B4
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 16:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FB2730100D;
	Tue, 14 Oct 2025 16:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ti5rXCMP"
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3888912CD88
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 16:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760457709; cv=none; b=F6cppnpSbS9D3DoxTxRDL2fyVpIf/uYf/bEtVCGPCGwwZiOskOCcV97I2NarnWFXoLDA2xrhYywUJo/mndclnlQ8xS6UGW9/YzcKmkMYsjr13vtT3CR5N/EflM3HUdWS/Rgc/8skFOtq9kxndx6F7LyFhF4IdIC2M+AH/L/lgD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760457709; c=relaxed/simple;
	bh=f/yjvNeAiG/w6HXlU8hc0Zzbdo6HDQWDJs3ftJ44QoQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kkCGesu3Ch+NZiMFV2ZMpQEcq551rzPksaub1vbRoz/Vk06HUiwGMyFU6o7ELzSTLBQtmYBwLtapwjBLhaTkvG5obuU9jrirW+PkGse9fZBYqTwemE1/UPqxtvsZBrT/PZLsdP9apPLZSkTZwdJbDozmgYmllGNR3e2sei2VDAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ti5rXCMP; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-77f9fb3bea0so46386037b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 09:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760457707; x=1761062507; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=f/yjvNeAiG/w6HXlU8hc0Zzbdo6HDQWDJs3ftJ44QoQ=;
        b=Ti5rXCMPuIpBQ9ENhGcIZdi7QGMoJnFrwduVMSkEC9Ap15KKth1TAfcrACm3oEXG1R
         gN4/qci4Yp4LjXDGDbgNqkCBDhxB90lnlOasQimr6ZVoxMIAJdl/gpzIuSXsruHhNqs/
         xxITvJuC90S6oQMDrby31JStsAWhfuLQ5W+xv44kxVtOyR5DlEor6LFyREMD6ZvMeuRJ
         HICQRtWAMcqBn2i1EI1mJMQdFR12eGorDfDFIa4sGWmrn1O/9+NwnJH5eZSsVBgNE035
         70OD7uQdelXLQF4CKg4bA20UPMBT/X8g+W+SNtXCN/TFbiLzvk1/VzVZgouqA9qwP2kx
         TPoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760457707; x=1761062507;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f/yjvNeAiG/w6HXlU8hc0Zzbdo6HDQWDJs3ftJ44QoQ=;
        b=AKvaxR1RhMaiKhIBW4tpcUAkY5dtUQOnprjhEyt2ys59myQULQSYazUTbmt497ICw+
         2yq9CqZW9tI1ojxRBCWNKaIxZd0D80qcFo52806PRd1OdtFGfHUr7RsXcXYQ6N95Zxm/
         hRKvxLqji8/gkWT8FyjmdcmSXdUN2IKBBSX19omSv58cQswRCPjNGu6+JCj1eP9oxLjp
         SvtwvcSVk00nqtvr7Thq0/Mmhm5YrwQsUiWOsvl68LxMZ8ZO+NI38cQRli6jbvdSX8A1
         nkKzETROT/RplGxQqFRIDv99K30EghsFy+EcgjNPh1YUyNKXFpRcm4VKTJkcRswsKhsN
         As5w==
X-Forwarded-Encrypted: i=1; AJvYcCWr8dLJeG7wxL8P7vr4npH2qHz9C+uefM+ea/dryg0SgE1c9fluTo73LunR2R7NJwjSuqIpa75kw7AvI7k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrcdPTLWbG5EQBrzLSQtpURX09+sJ6l0W38qh1d6UcDV+yyPrp
	0RARM+YO6amJw+b2CxzRsdScirk/gkWKnvbGeCFDn590LM6vkUIheVWkrKOhpsLVxLVRxquk9XV
	nDsj/+eP6x/F0VosBf47JJwtmufIuXmtvVqXFfoEy4g==
X-Gm-Gg: ASbGncsDW33QWr6gdQg8TdbvbuXmilzLTRpKG+b00FpO4YtdnMBhJgM8atTYU93HhZe
	p970ziV9Pp64vLDGInSc2Kjk6K4HOxL/unMtWo+cB1BjjRP1l8Wk/QpnDRbKuvtZ5S6W9pvyJxV
	wRybyH0oFW2aJ6TnvS2i+0qpdvmLga+NlAnsblkkXMNcbZLPS+tkDL5QMo9JNSY9H9s8EQQUaat
	vp3wTnGXr7WRR7dt1s4qubHbJlEx3VxTDCYXDWtKJjZzzOG5+SMvoFo7N9I/wLnbE0Uwq2TUrNT
	VIU2QZ3Jumw3wimy6g1qyVm78g==
X-Google-Smtp-Source: AGHT+IGlpqNaavmoJjF/rTRFjKs7dOdsBv7+wZ5/6Vvo5SHlUjQEOQPeIUBdypabQJr0k89JFdmbyrtQhHNALtFuUQw=
X-Received: by 2002:a53:bb4a:0:b0:5fc:53ab:a49c with SMTP id
 956f58d0204a3-63ccb825b6emr17067165d50.11.1760457703041; Tue, 14 Oct 2025
 09:01:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251014143942.643856-1-kartikey406@gmail.com> <CADhLXY6zA0EGhKjzBZXSv3QFC2OMHxTxzgZy2sObzNaaza7eLg@mail.gmail.com>
In-Reply-To: <CADhLXY6zA0EGhKjzBZXSv3QFC2OMHxTxzgZy2sObzNaaza7eLg@mail.gmail.com>
From: Deepanshu Kartikey <kartikey406@gmail.com>
Date: Tue, 14 Oct 2025 21:31:29 +0530
X-Gm-Features: AS18NWBXOM1m99KfAKGpTf5yz3g-4wshloXh0Et30lKGi8VyUx33nLhLIUtwwks
Message-ID: <CADhLXY4CmHm7tP+M3RzS66tA3pqt_JghbaF6DRozZBjtpdCzEA@mail.gmail.com>
Subject: Re: [PATCH] ntfs3: prevent operations on NTFS system files
To: almaz.alexandrovich@paragon-software.com, 
	penguin-kernel@i-love.sakura.ne.jp
Cc: ntfs3@lists.linux.dev, linux-kernel@vger.kernel.org, 
	syzbot+3e58a7dc1a8c00243999@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

Hi Tetsuo,

You're absolutely right to question this. I made an error in my patch.

Looking at the debug logs again, the problematic inode is #25, which is
a file INSIDE the $Extend directory, not $Extend itself (which is inode 11).

My check `if (ni->mi.rno < MFT_REC_FREE)` only blocks inodes 0-15, so it
wouldn't actually block inode 25 at all. This means my additional check
doesn't solve the real problem.

Edward's simpler patch (just initializing run_lock for $Extend records)
is the correct minimal fix for this crash. I apologize for the confusion.

Thank you for catching this.

Best regards,
Deepanshu

