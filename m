Return-Path: <linux-kernel+bounces-769252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6317B26BF8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 18:09:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB6E162356A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 16:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8A062472AB;
	Thu, 14 Aug 2025 16:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="is4eNz25"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8110A229B02;
	Thu, 14 Aug 2025 16:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755187544; cv=none; b=EPiWPswu+4P7CHToVAXYy1hxeguXZzYBlbw+KoOdzC23/PDWQHY94nekC1Uw+za0XfV2T9XHn3SCg31M1ZQOATJnQztDERBslflYMBcVqRlk8g0pev653fqXCj+T5C735NetrAfR3A1ynj899G4pMcpPoo5feQpT0i0yBxU+iq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755187544; c=relaxed/simple;
	bh=2VBn/q19MqFxQjSVovJsPcabVWmmz0XefCLtJliVmWo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dgSMkrImTUvJ+Q+QJrI21AIdle7VsXtyd7iVFapWUBt50qPW8PnR0ghb27uyAvZT/NQAGforM0jnssdN55pfsO9H7VKPGF2PlzMgLkJL/O0NlSDJ23+444sCSuyTbn5U0Ky747qAONwQMJJWEi22l0OiZzg6QY7xvgpHUxHgT2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=is4eNz25; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6188b6e79a0so1614437a12.2;
        Thu, 14 Aug 2025 09:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755187541; x=1755792341; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2VBn/q19MqFxQjSVovJsPcabVWmmz0XefCLtJliVmWo=;
        b=is4eNz25hodoyDne4Sm4q6ySLRarHBfeCvj2SHQE0h3/HK5A1b+m8uHEhAQaFYWAQQ
         9hgOoz2j7DddCVt8EV77dwRg/0gd+bIVrm7/ADvUl0tE/51NzgVLHGzBc1zE5lfsQK0A
         6K72bztGvgVmDdIdR7UcEN5sWTxE0j/F+5Z+ToOnYb034LTkfntRhjGFJrPc5uTS72xd
         49NZ/lDx+vwAdXShQKYwqfJvrTsgD0fL4XCip8bGY1P0LYenknoxezjpzJGWg1EA9OXB
         d42Au1rDKa0cafrz7+tn6isI+Pf9jkTFIQqjxjGe9VL02q7+dZ+FQ96eW2wEpbPR8IqO
         +Ybw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755187541; x=1755792341;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2VBn/q19MqFxQjSVovJsPcabVWmmz0XefCLtJliVmWo=;
        b=vKBOjC7Z4c+qYNzBHJuMDrYEBfj15G5nGU9Rl0rY8cnRjDJ/8buvGR2TT214uXQf2V
         R8vlQKlSnR8M4/3h8QNybpYnnmOpQndNiGNTrhtgF8nv+A9kRUUSAPhMtRdViiSZtxB3
         8Ln0sumoPOz+uLCmlGcA9MHMkm+i0y4sRnaUtBSCtw9lKK/lmMKqENfIq7DiHFRV4a44
         pC1IGGx6CYV+pBDwaBR9v0aXttoK1uICFYzV/oW9TSEUNKWiTHFiBruCFCH3pFuIshYB
         uefnx4YWA4IvQPa7YuPuq+ZUbKSKSBQi4gzf8ue/XqRYfcTYksv8TEMy+s04zOmNeD83
         KsIw==
X-Forwarded-Encrypted: i=1; AJvYcCUW790Qlbrc8y4QeZQAUBrAa0lv8jQRojHaQe9VvXgeoR7S4C2DSUBoyJ4T5UzL6ZzMW7ovy34F6vdriA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxII0YQpOX8TtbJzF8lU6YzwKZRtWFVM2sXNTmLGqjrDJMTMaN6
	TDF3ydi73+tmoDqKv9ALx47OymmrwIE1285Eo9/zYzd7nEo0bIzIQkh0
X-Gm-Gg: ASbGncsvnxpXIQDaQOSTm1N3e0qCNWaETGKkK3zSvKyEt3zrcQeFQqR0/5NEm8Vu+/a
	IDRYJQfJn5uf28iPKntIw7vegv+mPp4oem/VviI4w3qWNXgZ867pCBOvrddsU3w+2oal5t2B/0i
	Xxi5Dk1wqBia0i5+r9Mpqn4VD3IHwd4XmWsRR8LZUaFbEmu0vaaz0cQDer4kahthszmK6MPlrhq
	GSjkK9T9DFEU6i/pdipRQh5XdYHnF6jrnU34heHoyES5a6LgOaopQ0oMtJ9+xhVdu1+a92x7Ydf
	Mf1fixxq9ODvAOElxNn8A8L50B/IDJt4ssFUdKexxBLRI3EDLjhIUyXre6CVo6ySdSlSNG7TVQK
	MeHXBc4SsL3LpFwKFBPr7cjwiHija0yFykR3sEGtkE9z+Ejf0ABWHxgnbFwxol+vFQ016DfMZs3
	fiVMk70/Q=
X-Google-Smtp-Source: AGHT+IG5WggNgC2/hqpkeGTZv4PzkkEHiFlfXEjNy62djRE4DmAspEIhTs+rKOl1TP7K6jYTcO96sg==
X-Received: by 2002:a05:6402:5250:b0:617:e4ba:30aa with SMTP id 4fb4d7f45d1cf-6188c21d516mr3253372a12.32.1755187540529;
        Thu, 14 Aug 2025 09:05:40 -0700 (PDT)
Received: from localhost.localdomain (93-87-121-223.dynamic.isp.telekom.rs. [93.87.121.223])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a8f2b892sm24277253a12.25.2025.08.14.09.05.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 09:05:40 -0700 (PDT)
From: =?UTF-8?q?=C5=A0erif=20Rami?= <ramiserifpersia@gmail.com>
To: tiwai@suse.de
Cc: linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	perex@perex.cz,
	ramiserifpersia@gmail.com,
	tiwai@suse.com
Subject: Re: [PATCH v5 0/7] ALSA: usb-audio: Add driver for TASCAM US-144MKII
Date: Thu, 14 Aug 2025 18:05:38 +0200
Message-Id: <20250814160538.3269-1-ramiserifpersia@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <87qzxduchg.wl-tiwai@suse.de>
References: <87qzxduchg.wl-tiwai@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Thanks, I’ll fix the brace placement for scoped_guard() in the next revision.
If there’s anything else you’d like me to adjust before resubmitting, please let me know.

Thanks,
Šerif

