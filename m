Return-Path: <linux-kernel+bounces-768061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A06FB25C71
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 09:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0778F177FE2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 07:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F26E264A8E;
	Thu, 14 Aug 2025 07:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F23nymnk"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448692652AF
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 07:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755154823; cv=none; b=ormcziZL5WcYlC5alsOkq4/YUs1ecEly6WXygZDJIgJEqbLB4VRSp9TARvxMqBh/r7xv1Qso2w/K+teljoMEvmnfOkgnqpxxeKE+zBZzcKVSq5C4sDPDKhwSlqZrgpFvx50AwVjMPdUrHrtRTvzwDlivD7J4ceD5nWfjL0QJnUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755154823; c=relaxed/simple;
	bh=M3FaBbbwnwmPCibscdFtfSoUWdle4vcylYDd0+IcPTQ=;
	h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To; b=L31QOuX4vaCGZWkH/DrBRCqGsiSflUf7Sg3e1mNCaFnSGdP+MoSIbuRI17ZoK5AdsRFKd0Q8IFHbyCL3+5TNRK3DRmvg9U+Y/O3S6bQcndQeDu95gRtFm5wjk2FZvA07N+9wfGeONl9AZxp+1PB17kHuhBhIlaAOSd5dhf9nZ7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F23nymnk; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-32326e2f0b3so529470a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 00:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755154819; x=1755759619; darn=vger.kernel.org;
        h=to:message-id:subject:date:mime-version:from
         :content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M3FaBbbwnwmPCibscdFtfSoUWdle4vcylYDd0+IcPTQ=;
        b=F23nymnkZ9198SiyKUdeyWJ2dmny4ngU8HlsK+YpH6CFbw5luHkM5SbhVemsdoq6tO
         57qxr6Ua4w/drOk9KY/zoQ2weDL5zIIBewTsr1/gwgtVbtQVT4paqBmoibXP2ATqoJer
         q+LsGQTKXbps2sX5TvZ/rC/Z6rPavIeQjhVuvUPiwMuNmzWofo068pOgreVvX/5wFs4v
         0OvavvVwqZ+Q6cOqVbun6eD+VgMDOpLf2iYUVAzhcT6ZJELFOKsiOAxPTGzNf1nhrTbI
         0Iy1Lkpumadvw5i1x88ZhYWFioERJ19YpTjourjdaq8iZRUymrgAxeHVkbGKnxaalHdx
         b1NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755154819; x=1755759619;
        h=to:message-id:subject:date:mime-version:from
         :content-transfer-encoding:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=M3FaBbbwnwmPCibscdFtfSoUWdle4vcylYDd0+IcPTQ=;
        b=hgX0o+6BbMLWShJ8TSTmLTQGXaRElTrJFRz039e9Xrl4Q83LoDA6tr543/UqJdWxLD
         8jxtAOmPuzmCV9XtK0BaonsFc6CTUfTshZ1FOZRVsuauQ9fi0LVnMafa7HGOq7e+GQjI
         nYKLHaaRNYyUnsHIpRMqIJLPF3z20krfFITHuVoigLsRuXB6GTuq7F88vEfyqHS3Qc7m
         NLnO9+GK/gLMKxo2nYQomrZ/Y2NwYr1mKuyePONqdjyFUgVaCtOjZOPsM2R3TxGEp3do
         y++Ky+2J7y2VXfTlTXL1I6eO6pe8xHezakhLlvrOetiEmFzI9TByJTRyNjDYAKKnTBjm
         4LJQ==
X-Gm-Message-State: AOJu0Yy9h28rGAGa9j4SJZqEpPnAiXffxgXhWxV2MODDIE4dw69m5hAu
	DmTdmAK3qXzvTsEeL1oXSOsi1X8aeFzX36dioInw4yu9WnJNMLEzgrsLoV/pOhkv5eY=
X-Gm-Gg: ASbGncurg+slWRNwzIUDRwVCOYQAZQte+qS6hPRDku/W1b4URKq+KAoF5KDP7qI3prU
	4pSqMaz4+Xgd5v6hS6Sdkuf29yeDv/kYW8oDsjJofnW0+4Qe1NshfvGsvzqardVbRR+xhqfBmxb
	Th07idNacNduPlVwEdND4iSINRjEypmNRihwowCjY8TkduB+93zdgamU1K46rKQIHmQjAeM3lzo
	U4SOTeQrUrqATNB+/99mC+TBmWoFpr+dzmmSd6oLzEmOYgx5NARohCMkQ3DBsJaOcLSsKGP9Bxf
	2DtMqW6OI2ws7fByaOVShDhqLcqJieXKDfXUOQijOZ+/KObQq9GUSpfW+oU+qTGA5p1Lu5q9Ywn
	dAuODtf56dYbhmVynG0WkEPGOjmG+DZDrmt5jDLOXxr+Kf2oANkykMg==
X-Google-Smtp-Source: AGHT+IFkISuStv0hc88NyLRvERZzCSOQqIV0L93B3x6gFDCJwkeuAKUDv+c8jK5SZPixKIleYPDECw==
X-Received: by 2002:a17:90b:3d92:b0:321:38a:dd17 with SMTP id 98e67ed59e1d1-32327a62f91mr3227588a91.20.1755154819174;
        Thu, 14 Aug 2025 00:00:19 -0700 (PDT)
Received: from smtpclient.apple ([2602:feda:f113:13e0:f36a:c548:e0d2:957b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32330f9163asm794179a91.3.2025.08.14.00.00.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Aug 2025 00:00:18 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: =?utf-8?B?56Wt5Luy?= <zhaizhong.ly@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Date: Thu, 14 Aug 2025 15:00:05 +0800
Subject: unsubscribe
Message-Id: <89D6F19E-D111-4302-BC9F-F1408D7CF6A6@gmail.com>
To: linux-kernel@vger.kernel.org, linux-kernel+unsubscribe@vger.linux.org
X-Mailer: iPad Mail (22E252)


Sent from my iPad

