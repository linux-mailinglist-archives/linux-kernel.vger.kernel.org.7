Return-Path: <linux-kernel+bounces-894812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id ACD0FC4C24C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 08:41:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BFC084F0191
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 07:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D06632C328;
	Tue, 11 Nov 2025 07:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZK5R/GTy"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A4032E75E
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 07:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762846846; cv=none; b=Hdva3tajBMhq9RTKC45VdfqtLznF0CnHwvGeqosWzt0ZwU2lDdAKRzV5NRf3UZUFRGnmkMvZFaleL0Xpz8O87zQS6s7lp0JN9F+nsTLulUhSC4SSdZF8Vsoh5hOIFH/ahBehXwBCCXaP3gxkgFYZ85/Ekf517vBszNLGgZb0TrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762846846; c=relaxed/simple;
	bh=BXvcCjdO7qB+nC6mPywbTmCoNCrPFNZ+Cz9Suyc+IIA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=SlANaurec6kOglrj+v81RqkBdORWAUsXalW9dmiCVudbdxkPdSbok2fjwBmkX+g8d5GoijmYZsOxDr4JVo8MaoP+tzVFYBZ03qeOCvpPh+6caiBzuii0cQBkr38vLm0MZHfgBYeGxT76lW8T2TxONbEc7C/AiqJlP6ZP8RZTRD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZK5R/GTy; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-64080ccf749so6066597a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 23:40:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762846843; x=1763451643; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZsQb36AG+bhheqgPWqJ+04ViBL68K7NDw9cmmMWzaYk=;
        b=ZK5R/GTyhB1K1GLOvYd+np8/twX/3IJUELwy22GZsrbwkITpxssZ3FRQ0CIksB2IMK
         VO46EN45tR7Be4by/9hYyXkvS6xBmWgI3sm28q3gzzH1IHZjCcV1QP38lEXRPF1g4LxF
         76PazOgniBhfAXONZ86nnWCuRaSfYzcxyjp2CWGoKMPZEqFzMUwl9xwFonHyovErRbkH
         g4lFCFEKAoE06WnPLpIoiXFF43QDDADHw34+KKrE1YPEzTaygHs/7s5JpdyGS164VyIr
         xbtBrq8B6kpMX9S9uDwtEgnpF5eTOs4zten9tgN3UrkTgWLgSXauB3qd8hpnY4kVOUGX
         2EdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762846843; x=1763451643;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZsQb36AG+bhheqgPWqJ+04ViBL68K7NDw9cmmMWzaYk=;
        b=xRZ+0oY0HmmeZhJCwBlm8ujdjprv54ub2hdZE6uuyPiXWgxHTxIR4+sNmG6sHA0SyT
         zecl8z8C7S+TF1z/bC9BC8ugLPFh8Oh6OE+roG55R/LCrok5P6v/lisTGTgq+mijc6lY
         F9KIoVo9qgX48OjMiORChRn9HsGcpn0pnQw43/xvbROYBAc2gTg9ncOKoWb5/FofFWP7
         /0xCeyYVIGmAZ3Wv01cFxh5gwMAzYg3i3P1a06xjpJ1oHGHX8BBJV2B9n87/41t4bvw7
         Hotnc4x8yFRIUaKBGFZLllNyomtO04P3P0et4tZQMsc0cFPUZoFiNagqqsXx+t7fsUyE
         HrdA==
X-Forwarded-Encrypted: i=1; AJvYcCWG5yk/3mxe6adcyvxEc2VlpwWuwRKldY7ufVNqO9nsZRGIat2cwFTccfDL/06k0MW1+uph3ei87erYhMg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx04nsoNl2N6ljf7EjrcPNvGweWh6EsyUOspsiDxHUB2zjGNRPe
	pFli2YeT0XTzPgkKElxUABUs4tHt9HCXr+oUaINg3CSHHyV/mg7lXU+m
X-Gm-Gg: ASbGncsKoXyjYyuMxOUl7TuDTZzkr7MBXc43PSkrkNwLEujDgw+V/XBBiVnuqOR+11u
	LZ0m7WYP5sxofeWOgUx5tyF/4nZjQAdkVI9A0UKLZ2ory8kZz4PM1rYeHoWcCuNG621Pw1LzVfv
	D5XSv5U45xinhC8cK0ip6D8G/WON+U34RuWQvXAmlyqkn+JLUWNov7m10iWujLM1DGCaHEUZ9Q2
	YiwmvYNAgUoyFypWQYXA9c9yEahx/DD0P69QoPeayONSDUZR8j55+sDpjl5iPe2nQ8pJ6U5m6C6
	ndGBU9j9khMUaLTWP1eKPv7flz8MASSeewFLE1h+53em5YdgesvnIJVGWNVPixOhv5yIDx611Eo
	8hgiQfP8X+UVTuWvqHCyu+isObYas6ug2vCqxwKI/aRUrXHzKEhwap99aA6PwrGYnidfhiNbfd5
	IB5y/E5tm2U1xXaKT1ioOjTOWypN0Z7w==
X-Google-Smtp-Source: AGHT+IFgWTXwLMk5JFvVCa+4XZXkf4lHdagCP7wOpENFy5OZ1ezyvwlm5aeg76PzyxRG//MwPLwN+Q==
X-Received: by 2002:a05:6402:3045:10b0:640:f8a7:aa25 with SMTP id 4fb4d7f45d1cf-6415e83eeb7mr6906192a12.30.1762846843459;
        Mon, 10 Nov 2025 23:40:43 -0800 (PST)
Received: from [192.168.0.253] (5D59A51C.catv.pool.telekom.hu. [93.89.165.28])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-6411f713a68sm13060667a12.2.2025.11.10.23.40.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 23:40:41 -0800 (PST)
From: Gabor Juhos <j4g8y7@gmail.com>
Subject: [PATCH 0/2] soc: qcom: mdt_loader: minor cleanups
Date: Tue, 11 Nov 2025 08:40:09 +0100
Message-Id: <20251111-mdt-loader-cleanup-v1-0-71afee094dce@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFnoEmkC/x3MMQqAMAxA0atIZgNNQUSvIg6xjRrQKq2KIN7d4
 viG/x9IElUStMUDUS5NuoUMKgtwM4dJUH02WGMrIjK4+gOXjb1EdItwOHe01FDFXA+mcZDDPcq
 o9z/t+vf9AHgK5l9kAAAA
X-Change-ID: 20251110-mdt-loader-cleanup-21915aa7b09c
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Gabor Juhos <j4g8y7@gmail.com>
X-Mailer: b4 0.14.2

The series contains two small patches to clean up the mdt loader code
a bit.

The first patch merges the __mdt_load() and qcom_mdt_load_no_init()
functions in order to remove a superfluous wrapper function, whilst
the second one renames a parameter of qcom_mdt_load() to make it
consistent with other functions.

Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
---
Gabor Juhos (2):
      soc: qcom: mdt_loader: merge __qcom_mdt_load() and qcom_mdt_load_no_init()
      soc: qcom: mdt_loader: rename 'firmware' parameter of qcom_mdt_load()

 drivers/soc/qcom/mdt_loader.c | 52 ++++++++++++++++++-------------------------
 1 file changed, 22 insertions(+), 30 deletions(-)
---
base-commit: 682921ab33129ec46392b27e9dafcb206c2a08dd
change-id: 20251110-mdt-loader-cleanup-21915aa7b09c

Best regards,
-- 
Gabor Juhos <j4g8y7@gmail.com>


