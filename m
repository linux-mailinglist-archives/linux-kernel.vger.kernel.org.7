Return-Path: <linux-kernel+bounces-732452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D704CB066B8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 21:21:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2ED015658BD
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 19:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C8932BE7C2;
	Tue, 15 Jul 2025 19:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3+CJMyf0"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A10326CE1C
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 19:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752607262; cv=none; b=UQmIq/gCcTn2TPNLSckB7a7O9KFyhJmn4ztEDT2rFSVvR5gnpV3PqiM5YSlN13EZEdIdiaEZ/iWJMBQGm63y+F7Xg6IcV1ly+rOtgfhOZ/ULf26inK91u57pBvNLEuro4UHgGys1X/ynhqueZaX5nfou9EGcyeh2OYlQwJf6RJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752607262; c=relaxed/simple;
	bh=tQ/l2kGsknXYJgcrQryjZtkeQfE1o01QgQp8Q3K992c=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=IgvEe+SnUcNhH7dVAdc/Nyhf+1Wc61Fu4VXea2i8+Q1zzbjt3ybrswmkr7TecJwthRHdB0d1D8q2MFyGRJeH626EH7EIwUoV6u/lUpueLycAG1PRIgpZGwJyv/LXCmUxLBFh210MvjAgMLrWaGEHdMBrn4SaCeq6VhUeSSlaAF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3+CJMyf0; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-313ff01d2a6so6419924a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 12:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752607261; x=1753212061; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tQ/l2kGsknXYJgcrQryjZtkeQfE1o01QgQp8Q3K992c=;
        b=3+CJMyf0zFjKaezbsg7atwsw5wGeSmHxr8Ws64F5xrJNR1nJOgkRo3KUySnL8D8dc0
         htOvIHLjTk/bBQ9NM71Qm2rmlKq5CVxLxyG6UlSjAljlJdVDi5z5sfsYAPAEvhaEegX9
         Wv3TWXJADxbyhU+C/zY2qVoQoucD7dDpLSJ6bgu0Idee+9DabBFeR7jIHqiO7dhtjl8n
         d9yu1i1Fj5BepyFEdt+l8Yw+0mZdfFTTUj5qcOGUd79kIauS6O0MpcWUnaR4EIB6eiWU
         J0kthIER85Rfd+ngkqMa87rflK9PlL/ElhOvgrL34NQ/0WB9ruguH6BnkEjNo8mASzcV
         AqSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752607261; x=1753212061;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tQ/l2kGsknXYJgcrQryjZtkeQfE1o01QgQp8Q3K992c=;
        b=b+Lfl66a4hXCTuVlkEGlXyIReE3PZd1S2K1KgqEYgTmzd7shj24oOw/+kZjVBCL41U
         Ghd/Fev+DaP8MumRS6D3OnsCQpDq1WzEgpNBjQlntLqWfeVKeJE72FbrT32iZ02j47cp
         xRlVsh5l/lkHdpNERc9z84TGgjiR2uLhskOM3zDkXomGHOkzHfu76kdtUkWi80E7r3sI
         tc2PDkEaJnGfZ/AYq2CVCZaLlyTBi1sIM/J6q+Lnrl1ljr9WN6cY9uAXNqOXSo+p3r1M
         0UPN7UWJ6JVN2g2w0rZBueJ+i61DirGL0ebCxz1CmVXsT0DrmWnimQgUDWqvv9Z8jVWw
         fyOQ==
X-Forwarded-Encrypted: i=1; AJvYcCVdSzeE3vQf1uyk9lh5fxH4zCzkjnVXcAVqURK07a/v6pVhPWk5CmIcTZFqHmy2OLnzrkPfL6cNJOC82jg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKXa/D8ejmuA3MJzMDyySuYIaEHLvgURXEDZQ/Jy/oYlzlbcpE
	fI1AJQpXac1KzqOacJFbqJ1nQKVIQuPaRkgLgLTWfKqbN4MBtlZqTREBXvfBYNC3g4alBc27nR0
	FHyuWNA==
X-Google-Smtp-Source: AGHT+IGJywdBfeyK1E4aMcIC63AEdlB583+D5TiEUYz0wX9xLYkVmcHHpm71Gk7QmZ9DlartAf0cxOa5NQg=
X-Received: from pjyr15.prod.google.com ([2002:a17:90a:e18f:b0:31c:2fe4:33b6])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4d:b0:311:eb85:96f0
 with SMTP id 98e67ed59e1d1-31c9e76be29mr527056a91.29.1752607260807; Tue, 15
 Jul 2025 12:21:00 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 15 Jul 2025 12:20:57 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250715192057.1901877-1-seanjc@google.com>
Subject: [ANNOUNCE] PUCK Agenda - 2025.07.16 - CANCELED
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

No PUCK tomorrow (July 16th), as I will be traveling and unable to attend.
Though as usual, y'all are more than welcome to meet without me.

