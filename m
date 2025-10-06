Return-Path: <linux-kernel+bounces-843161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AAF59BBE891
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 17:48:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B9D23BD57D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 15:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F33BB2D879C;
	Mon,  6 Oct 2025 15:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GNZwWqda"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A5A2D7DF7
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 15:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759765699; cv=none; b=i9YvDxwuDiVCkk0Qf4K5JvSxKxBlzOE3QD17iPnov3PffgwxmDRhQbQekeCd+GoOBZ5YRSwxsr/iIz/Z1idWSKHfu767/wM/CCsjkNLPtZaflnQIVQU0Tq+C0Q8QPuB/7xf8sF+NryHlHfj88a62vLqJYfziZ/9PhSJnXkStjfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759765699; c=relaxed/simple;
	bh=BUomoTM50ZpVJiLs3X6oVZX0pfV6Je/dUk1cBR7BzMM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=L0Mxh5z+klt/ihZQy58edIEz8/B6nobpogQn7IxgdYf7fmisZGH5vquBNDL1kXjBaKLLuA7BvskHurSWFr3nZXb/GNh1V11Hga8R4ibN15dJmlvp0xA7cjsJjHFjFbLjZLq44p57BoFN7fHtrpWbUcxTHh38ZjBbBIrOij2YWTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GNZwWqda; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759765696;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BUomoTM50ZpVJiLs3X6oVZX0pfV6Je/dUk1cBR7BzMM=;
	b=GNZwWqdakp89luWjfEDHhx4dReBNKC2Ai7KC0aszJGioSCLo/imgg+m9G2kIyppeDs9iCe
	Vg03E/cNc+Mk2fs5W1BzEbhfs82Owec25XiazcyDlXGTwXnXKMX56QtiKJF78nkdlqRkTB
	8hyZLabC9rCBZYiSsClw4+/s4riKMLs=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-257-HS1ncar9M4Oy7a-AI_QqFQ-1; Mon, 06 Oct 2025 11:48:14 -0400
X-MC-Unique: HS1ncar9M4Oy7a-AI_QqFQ-1
X-Mimecast-MFC-AGG-ID: HS1ncar9M4Oy7a-AI_QqFQ_1759765693
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-78e45d71f05so102800396d6.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 08:48:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759765693; x=1760370493;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BUomoTM50ZpVJiLs3X6oVZX0pfV6Je/dUk1cBR7BzMM=;
        b=iZ9u92wK/GYcLoMP18KQWlgpWL8T03a2sUFeBURC76zI4gGBD5xZpLTeiAaDn9YnnK
         aD+EX9Unvq9vPB3B+tlgtXAbqgRVvp5K/MEx0X96bBBPg70QFfdNUJKooibtSQFG80B7
         pak4/gzq/1a/U78d844Z+mbK1qI/Rl/u1c487Ug2GVUqE4aDqMAKtlS4Jxikhu3uKtsT
         2RuX9JxEbAp6fPevnIn5ISt/7ReOg2HEkO61ZaIO6vUAEzO8quPoj+xB5N8/OZZaRRLR
         eG7nDMmljTbOe3wDWd5MT3J8D8Jsgk/ztxAR5k4f50xTud/TafSMKoDpC1uoD5FKg2JF
         CKiA==
X-Gm-Message-State: AOJu0YwV5i9owc/VKrgkCWJR3u/ZKV3LxajcKyzUQxB3VZ9P2alndFyC
	H4bINu+gyYtIZpEoXbxTaUPY11COMv645uTi9QqoJ35rETF4nlUlYNe0xTtxP82TZCs+GcINmip
	H7miHwhgiJx2NCMRuvmrYTNKlSbJU/oc//o34vdVmSa7yGzxvX4Mwlsp7PUKMOSd+iA==
X-Gm-Gg: ASbGncuh7sRBmx0a+8QJw3XPYKwVAhhf/Jcfrowsq/+AbyvbuKA05st+Tu7QTIo/hZa
	vddvEQUSvhw+LToxnJuLmQWmF4a+b7kFtwzvVAUN3vb4ZbbIU8JRbW+CQiArsFua981mCHfK/gX
	tF3rb9zZaWFTMdDVFE6CSLqgUL0w77JV/iRJ+MmUSa1gUhGUE4ab94ChrrGn9jOg2dMaNltnlDY
	Q6LmMghHkl8UnADfkeRfV8F0iWc92RgmKkA9+JNQJkVujUrGG1nt1x/N/M/dza5XSclL4ZW+8tl
	tsLLKYfbphvE3a0Uywx57YiubZ5DNzo7Ng3Ue5syas9hcW14M5iFfNNtSsCnhV496D/NfySbF57
	kYw==
X-Received: by 2002:ad4:5c62:0:b0:820:a83:eaec with SMTP id 6a1803df08f44-879dc83ba80mr158373216d6.35.1759765693544;
        Mon, 06 Oct 2025 08:48:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHfLZ1f3qpnRgTtZvkawGBLghHiAlBOXN2Q/bWoviGmMhDGlpipOxyVJQE/8jmdAneAYFG3Wg==
X-Received: by 2002:ad4:5c62:0:b0:820:a83:eaec with SMTP id 6a1803df08f44-879dc83ba80mr158372046d6.35.1759765692276;
        Mon, 06 Oct 2025 08:48:12 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.minnmso.csb ([2601:447:c680:2b50:ee6f:85c2:7e3e:ee98])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-878bd786797sm119195476d6.39.2025.10.06.08.48.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 08:48:12 -0700 (PDT)
Message-ID: <b98f4e857bf20ca9d46c8f30b68d7705e5a9c506.camel@redhat.com>
Subject: Re: [PATCH 1/2] tools/rtla: Fix --on-threshold always triggering
From: Crystal Wood <crwood@redhat.com>
To: Tomas Glozar <tglozar@redhat.com>, Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel	
 <linux-trace-kernel@vger.kernel.org>, John Kacur <jkacur@redhat.com>, Luis
 Goncalves <lgoncalv@redhat.com>, Costa Shulyupin <costa.shul@redhat.com>,
 Wander Lairson Costa	 <wander@redhat.com>
Date: Mon, 06 Oct 2025 10:48:10 -0500
In-Reply-To: <20251006142616.136296-1-tglozar@redhat.com>
References: <20251006142616.136296-1-tglozar@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-10-06 at 16:26 +0200, Tomas Glozar wrote:

> Also, fix incorrect brackets in hist_main_loop to match the
> semantics of top_main_loop.

Oops, thanks for fixing this!

Reviewed-by: Crystal Wood <crwood@redhat.com>

-Crystal


