Return-Path: <linux-kernel+bounces-769199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E657B26B56
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 17:46:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14D8A5C0483
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 15:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61BFB1EB5DD;
	Thu, 14 Aug 2025 15:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mYJfRnuo"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343BB32144D;
	Thu, 14 Aug 2025 15:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755185892; cv=none; b=ePU4V217eZARh6Up+c1yjpuEhnoer8yuEMmRhI5o+s42M4FEfTQKcqb6J+2hZRy/Ic7O3NE0/pWUTQH7IcDLDILtwudJNzUmUgCn46ZJMrs52klZkN0ATIOTs+pLYQCJAYeD60AG+97/mfvmQJSK3zjF8bnWEZxhYzAnBcPGN/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755185892; c=relaxed/simple;
	bh=jLhYJU88sZxBCe9SefYGees+F/ss1OWTb33Sg75mSxs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lYlwRIsY2n9OcpZBuwzxorDx6XC9kzRemeMPF73+M1attGYoYZRT07/WKALIuW0tuASy6DcSndcgmNcyI08Z5lGnDF8rJqFP1P9FGcCRVUm29clOvaoMO4OqD2X2QJJAPXG8/X4T4fgq3uGmFOR69TfSG4wTzitMjbHbGypFuK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mYJfRnuo; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-afcb7ace3baso172666966b.3;
        Thu, 14 Aug 2025 08:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755185889; x=1755790689; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eKf5Uw9bpy4LJVUlx+RGUE8QW84u/SWmHMh9fX7TDFk=;
        b=mYJfRnuoXnf+RXpS7hJYbUc4pK87SRd+kFv9OGSNLiiHnktQd7M5L8YxvViHkhFXAg
         laHgw/RJtb8gsSUKyeh/E4SoYywoqScPhndgshNki9RoCQdx6VPB7Mknz/X6eQNh6/ev
         DO8XBrSBxo9F5Nk7gPb0qASptu/SHNYecAkqJ08DJEjR5L/++/Hbqos0VNVlRCNSmgQe
         r+fN3f7NrTusP8IamzIplVHJ2sj+xIXQzHBtPbXeYSjUpq9MqVEQxWvFi3Bcy+X8AYS9
         i8Ml0Aq1/3yzzTGu8M+i1VBwOOAbtZmjocxJvuxURl5DoFcffSp+78O7ApQ0bL959IDn
         nVbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755185889; x=1755790689;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eKf5Uw9bpy4LJVUlx+RGUE8QW84u/SWmHMh9fX7TDFk=;
        b=JJU7spWPq1csf9pmCPDnFJlMvT3kBAgqUF4I6FxwRyNep8dBhK1EPhwDYWuAeETqut
         TmSnL7oJ/ZKsEQr3/gdFerjlZ818IPk6r083G/bgUMr9Rn8fTITeRLg5APN0ncKQtYt2
         S/AM5nS4+G617H3gIeIEVUvdwLteJjRJJeL+ob0651a3Q6mbku1Gm7zUllQYlzNuDrOm
         hgvFfXoZ6mZsd7t23/pBUwEXTafq0PIqHmFlWqEHh92YVmjsoTRi8obN8Goo0Z9Kr59i
         EpHkmRBTYmOqmmhs2v0/SrSwUFXWyMKj7kFS9ooGSQmWiKzj42COXBucWJiz5pj8q1CR
         SW+A==
X-Forwarded-Encrypted: i=1; AJvYcCXs/mKlcDSr2dm4smjweRrJWxX72aWrdEbRJt+SxUJCQxwOFd654CfTmRGZ0NrqEiTYkeHyi5BmZkvWZg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0v3qnP4ZxHbaw10y8bwYwsx71TynhTjwuY1/2xpwNz5kgaPMP
	dPxrw2xMuCb9FM9PxgPlP79g/3Q0/zRCIDMGC4Nc2QSHoNQbtoSH+fuq
X-Gm-Gg: ASbGncv4RKmmotGwMhmhwXrEb/VHhNmP1NgfvXTbdEwlW4jzIRuIZ3b35jG7otVAH6R
	cVpNisMXcHnAQM/LySvyJbovSVuGFL5KIuu9KERGKDIuNte7eIbEcJ7WWJCc7dOCuPqT3/j+uN5
	d0L+lNjZz61Xj/OKlsfeAQrSPamtGQvXB+G/HrKi1rh4kzw5d7uUKrGmGwBKr+x1s+GAg4qgIrz
	gIkzYAelL4VJcw5/Sc2O9oUZmm2H8sjR1k+Pc/s4Doo37TV9oOKwAdtrS8afYyBiIHT3q52Oyxj
	L3r1PUPGVS180YyN3k6FOzss5j2pA29mr0vvVZBiXBCiAlD8C1DC4Sbms9RYjNU9xQj9xmdDrUc
	weAfnRAv1NzjlLnNCwPeFrcMUX+IvVoqiOSIQvLWAnbigP77CoFjq6tuC3M7EMKPN/WM4OL39rM
	8OfIzIzw==
X-Google-Smtp-Source: AGHT+IEycjlQEzkkqgWSPc87Yh4VbiCOsAw66b43QafRHA+YKsPDKsQG7aeMR8yEhckT3Lm5e/Mapg==
X-Received: by 2002:a17:907:608d:b0:ae6:c154:8059 with SMTP id a640c23a62f3a-afcbe1b26ecmr279627566b.37.1755185889073;
        Thu, 14 Aug 2025 08:38:09 -0700 (PDT)
Received: from localhost.localdomain (93-87-121-223.dynamic.isp.telekom.rs. [93.87.121.223])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a0a38aasm2619506866b.37.2025.08.14.08.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 08:38:08 -0700 (PDT)
From: =?UTF-8?q?=C5=A0erif=20Rami?= <ramiserifpersia@gmail.com>
To: ramiserifpersia@gmail.com
Cc: linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	perex@perex.cz,
	tiwai@suse.com
Subject: Re: [PATCH v5 0/7] ALSA: usb-audio: Add driver for TASCAM US-144MKII
Date: Thu, 14 Aug 2025 17:38:07 +0200
Message-Id: <20250814153807.12834-1-ramiserifpersia@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250814102534.34439-8-ramiserifpersia@gmail.com>
References: <20250814102534.34439-8-ramiserifpersia@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

While reviewing my v5 series, I noticed that the default values for the
digital in/out kcontrols were lost during patch splitting. They should
default to 1 (currently 0), which is incorrect for these controls.

us144mkii.c:

@@ -489,6 +489,8 @@ static int tascam_probe(struct usb_interface *intf,
 	tascam->dev = usb_get_dev(dev);
 	tascam->card = card;
 	tascam->iface0 = intf;
+	tascam->digital_out_source = 1;
+	tascam->capture_34_source = 1;

I will restore these defaults in the appropriate patch in the next revision.

Thanks,
Šerif

