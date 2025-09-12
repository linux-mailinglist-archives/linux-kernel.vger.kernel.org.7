Return-Path: <linux-kernel+bounces-813307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 407D6B5435C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 08:55:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66ABE3A3EE9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 06:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B305296BDE;
	Fri, 12 Sep 2025 06:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="odGdYf+E"
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C4B25A322
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 06:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757660102; cv=none; b=EzOXjUZWQD7flmJkEKCv5MZrUgoC+g0mMMq6dQllbdtrfiTryTMMYJCwGOdJKxNFXhP12KFiZHUQWlYBCNiZlHl0OwCc5NsUEQUebjFS2KEUCFsNgj3/v/JMYB/g7CcRJTrMoovq+gWZ0o7cIZdwJSXCiX2LRb/GB+BMfHsxX48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757660102; c=relaxed/simple;
	bh=M8m5mxvOMyfelUhWWg39ciFRBAfkWyQP6AoBvIR/Tlg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R3E1PfTW9W1fai2yF1F22uKrxiR84vQOeR2kZ73LrmY+tSTWqiArToUgkyztnYir7cNmCmVZiLDLTGr5i4wcQfLRmT4Rh9oXTcM8qAkEFNnAwv8jU5VIf7qc8tG9sch9j04Imxd50yVTMX/U2+/mrm7RXLDn9sAr3uzeNoXOaM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=odGdYf+E; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e951dfcbc5bso1388394276.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 23:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757660100; x=1758264900; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=M8m5mxvOMyfelUhWWg39ciFRBAfkWyQP6AoBvIR/Tlg=;
        b=odGdYf+EANWjrNB/wairDgpBvOQ54S7WuCvIBPR7sdJKLGIg8lTiubIl5lXbrtpkel
         D3mVFQTDKiNIqW7W3UlPIYLBqMx+TN0O/huoPf+oIZP0+voElk7a9AzBrD1nrdNJP3WU
         UTusjriqHE3QWFN9B2Sg54MOMIkW+8MNMILIHb8zgAM+zMVmgQd/YioSjgOCtEzv8LAZ
         CUnJubQYqeNbxIaeaZH6ptp/n2f+GgTO/MhpVwIts1sxc/Sy9+gdW+YPPTTJEQFNVXqf
         Z2BnYTW2D0ge9oioJdivPKuFsn3MDVv6uSH76wJEooxoQp3k2Evr653fAnljiJ2i+j/M
         CmTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757660100; x=1758264900;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M8m5mxvOMyfelUhWWg39ciFRBAfkWyQP6AoBvIR/Tlg=;
        b=g18B8AofdVoa6zRVyv53UmADYNXHvzTvs3h7ErfHbN215hqmFNKGQ30v1C3eleg5I0
         lLoV/qYclxsSDWIVigjytbwnpm4eXPjRLOg7vWS3CC4fn/sifNxUJOUAw3FSF2CQOP+O
         ojOcypYfgQW5AFMD3rjZxxAasLxitpYPlXaf+Fl2O8DNo8XAmQxeOvV/Kew3WmEr+ybp
         Cf4aE/RiT4G+uD+Ld6Gk178NkEA8eDVU0+XX4z57u7jhEoF0RW114zeCZQlE0RYwmnCg
         Th1UkV2yoBnNpX74kAD8pmzCKHwQSCfENQrCAI9/k2/rQ6SYWmdcBVZQApDAtmLKHyQN
         r1ag==
X-Forwarded-Encrypted: i=1; AJvYcCXT8r89JhyZ8ZJuc9gMGSaxJa77IXadw5NbwSqFePL9Sns4d4TLLUTrDA/14fhHVMhiW1jGNobvv5D0Lrs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7cPusvySRaW8+mN9XEU9c8sfYBQnwuuXqRarpRTT760pKSb0x
	gMcnSWjP/H6ksYRC1HDJUmurU2e0xeSTFkwvTvZ/mW1xcokLxobB1Qqc8bGJjfthZOxXF+qe+gl
	5a9pJt+wBrmWC/XrDEZZwIm10fCCL3qm4GYTEmkpc
X-Gm-Gg: ASbGnct6JIueSp+/IrfGbzRtFxjr9sw0B3a0KbJQR5Vb7460skcycOk2kQD2XRTFCll
	peSH/umoVdPUeNfeOx/f5KCnXM1isiXyzxpwyy4T5/AkvMi8ZYn9y7kHeZohj5+w2Id20qXSxut
	htU4Fj/TC0WgOWmkoiPd9us6rQFh3TZVjBVO6+0lvW5CXAI6plh51/yFMS1602Q4LA8zo+b1cSX
	qd3pj5JC74N9NSBY0DAYCCXixQccqYtqwRh
X-Google-Smtp-Source: AGHT+IEyMQa4qPU0KE+hX3RYmz5N48S+SV/AkytOR7opAhUTIZtTp8BRPBVeAijhywoAi5QY2RgyFCQKocEt1JvkAAg=
X-Received: by 2002:a05:690e:250d:20b0:628:df16:3193 with SMTP id
 956f58d0204a3-628df1632fcmr325353d50.24.1757660100065; Thu, 11 Sep 2025
 23:55:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250912052919.229757-1-dawidn@google.com> <aMPDLn05CwwEX9EI@visitorckw-System-Product-Name>
In-Reply-To: <aMPDLn05CwwEX9EI@visitorckw-System-Product-Name>
From: =?UTF-8?Q?Dawid_Nied=C5=BAwiecki?= <dawidn@google.com>
Date: Fri, 12 Sep 2025 08:54:48 +0200
X-Gm-Features: Ac12FXxhLIZGITrboDgd4uyjaz3guDR8AnkdH_jhjnU-k6vLaKjKkR01rcCS3ow
Message-ID: <CAJ_BA_CW0ytJjym4=v7JQMbdzg3Ny7uVwrz20RADiyjk7cJ=TQ@mail.gmail.com>
Subject: Re: [PATCH v5] platform/chrome: Add ChromeOS EC USB driver
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: Tzung-Bi Shih <tzungbi@kernel.org>, Benson Leung <bleung@chromium.org>, 
	chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org, 
	chromeos-krk-upstreaming@google.com, =?UTF-8?Q?=C5=81ukasz_Bartosik?= <ukaszb@chromium.org>
Content-Type: text/plain; charset="UTF-8"

Very sorry, my bad. Something went wrong with my git/editor.

I just sent the correction in V6.

BR,
Dawid

