Return-Path: <linux-kernel+bounces-734004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EB56B07BD7
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 19:14:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7D9D1C22581
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 17:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B64F2F3C3E;
	Wed, 16 Jul 2025 17:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="OnWenuOc"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532B92F5485
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 17:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752686084; cv=none; b=M+AzmHCTjwrTAP4JRsH1WUTqX3H43abBPkSZRzy1I2CXXC2c7pHPjFtfn3wj2c+gW6B0Zbgqogd5yMi2XbxoDSbF5TElrlATg9ISM2GjZOkulUcZWwPBg/ntv4CbS33ZlXb9XfHLQVFnJ/ohQyNJ1YQZwu3yDCHpyWGKG6KckA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752686084; c=relaxed/simple;
	bh=ejJgDd8MpCT57JoOWrwTBC5xvD/+ns3FTHgTDYirhEk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=sl8JtWdMlSMhO0WMGL8d6/grU/FkXOcqjcCbVZCIu+apsiX1VIvZBm/qd3EUxUWHz/qAAfyres0nxSKMCAe4srWrlz+L1yR9xQaT8veL0/hcA7AtkuooWL9DX/OrRn0RYVgIXoypWKHTmISO5SDhbkSR1erOTNWLxwXrvfnnVRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name; spf=pass smtp.mailfrom=chrisdown.name; dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b=OnWenuOc; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7426c44e014so181862b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 10:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1752686078; x=1753290878; darn=vger.kernel.org;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qeBNGJJp3kyBdCsSWxsDFjNHn9eObMtgXl0SO4K/NyY=;
        b=OnWenuOcBJ+NscU+EouZSxVEFtZHWBfZh2cjjxJ4qpSGYLLwT2xCaa+vm/dNTPqoCg
         yZ9R7RKOdwG043L9gWHTCye0Y8JgC/0tuqcF2UOzQEJJtp6bA7K5RgajdBKar93MCkQ8
         KTZTdLrMxVb4/vs5HXdGIKep5LTLnv0+Sq3ts=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752686078; x=1753290878;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qeBNGJJp3kyBdCsSWxsDFjNHn9eObMtgXl0SO4K/NyY=;
        b=v2GDdwdD6So/+WaWhWCGSUmvCaIegpvzqRVqtF6Rse07dNAbBwyjePai+QLDJ7eZnz
         YjxBB/UAR1fOjaJtEamqKN1E1io+SL3VyRpbM0pwmX/wWJZqXWTp8372Y1EdpQy/SQjh
         SvWg2j9fkZ83csaLD1r2Iuicl3cp67gKr0+aZo/R1kOZZFJwb//yPT7s5tmJxs6tmszP
         u2TWwFAm0hHQhAVrYlzoyNEHyjVTGinR3bRvfN6WAflc91qwEJHeIrjqI50PqkhGk0CS
         gNih8cBdzKTlTv0Vc9IwfZSFl2xyWgaOTbz3iTHN1yfP25mh78wLV3CERZtSNMMW1dnv
         Mj+w==
X-Gm-Message-State: AOJu0YxNocNlig1c9DKMzPZcbcssrIw8OHDR5ESQwcTzCBUZ5CBFpZQl
	rslQxk8cKPfRIM1eY/h7oTgdXjFaEmXBJq9NehQTsDufMz72TsRUDbpYDMwEuBWDYSzeXAwygLM
	jor9uRlXNlw==
X-Gm-Gg: ASbGncv2j/xziAU9JV8u7duSsbJu/n9R9Y19w4LcbcNdzxzTIfxCiM6UvtBC29pQ2B/
	wj+MCydRsRj0oVFzK11d8aos4yoG3LawP0HlCss43351EqQJdfE+586XJhlmnUPdekRBwUVJ52Y
	O0m9sZM+xklj7YCQKmPkFNN5cYlLm9yzYHI3IEJC5ZFm0V+tJfSM/bZtyMG6UHQylK7G8vjZDTU
	0LyMwz1rwt72Bih9CkTs8fTLIOnFZ3sPzTeCeSMvAna2NIr049NNLUad9JZpHSNTgDG5TafDZWH
	Kj+itqbLux9/b5u/CNUOuCGAJxZ1rUMcSHqsKeH8UMMw7os2X+dm1Xi1opEOgSqBdSI778zboyp
	X5D+S0/W3JJkRzOxUnO4WLK/WGg+SSM4=
X-Google-Smtp-Source: AGHT+IElKGgfKxTCBTWr/+7lLox2k9YVASZ6P5GjrsMkDgEwyDJzGJJ5DL7tt1YTGHSHLU2xgMgjcg==
X-Received: by 2002:a05:6a00:92a7:b0:74d:f997:1b45 with SMTP id d2e1a72fcca58-756e81a0b16mr7184541b3a.8.1752686078431;
        Wed, 16 Jul 2025 10:14:38 -0700 (PDT)
Received: from localhost ([101.127.220.50])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-b3e66e96464sm5253647a12.19.2025.07.16.10.14.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 10:14:37 -0700 (PDT)
Date: Thu, 17 Jul 2025 01:14:36 +0800
From: Chris Down <chris@chrisdown.name>
To: linux-bluetooth@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@fb.com,
	Jaganath Kanakkassery <jaganath.k.os@gmail.com>
Subject: [PATCH] Bluetooth: hci_event: Mask data status from LE ext adv
 reports
Message-ID: <aHfd_H6c9MheDoQP@chrisdown.name>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/2.2.14 (516568dc) (2025-02-20)

The Event_Type field in an LE Extended Advertising Report uses bits 5
and 6 for data status (e.g. fragmentation), not the PDU type itself.

The ext_evt_type_to_legacy() function fails to mask these status bits
before evaluation. This causes valid advertisements with status bits set
(e.g. a fragmented non-connectable advertisement, which ends up showing
as PDU type 0x40) to be misclassified as unknown and subsequently
dropped. This is okay for most checks which use bitwise AND on the
relevant event type bits, but it doesn't work for non-connectable types,
which are checked with '== LE_EXT_ADV_NON_CONN_IND' (that is, zero).

This patch introduces a PDU type mask to ensure only the relevant bits
are evaluated, allowing for the correct translation of all valid
extended advertising packets.

Signed-off-by: Chris Down <chris@chrisdown.name>
Cc: linux-bluetooth@vger.kernel.org
---
 net/bluetooth/hci_event.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index c0eb03e5cbf8..077c93b5fae0 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -6237,10 +6237,14 @@ static void hci_le_adv_report_evt(struct hci_dev *hdev, void *data,
 	hci_dev_unlock(hdev);
 }
 
+#define LE_EXT_ADV_DATA_STATUS_MASK GENMASK(6, 5)
+
 static u8 ext_evt_type_to_legacy(struct hci_dev *hdev, u16 evt_type)
 {
-	if (evt_type & LE_EXT_ADV_LEGACY_PDU) {
-		switch (evt_type) {
+	u16 pdu_type = evt_type & ~LE_EXT_ADV_DATA_STATUS_MASK;
+
+	if (pdu_type & LE_EXT_ADV_LEGACY_PDU) {
+		switch (pdu_type) {
 		case LE_LEGACY_ADV_IND:
 			return LE_ADV_IND;
 		case LE_LEGACY_ADV_DIRECT_IND:
@@ -6257,21 +6261,21 @@ static u8 ext_evt_type_to_legacy(struct hci_dev *hdev, u16 evt_type)
 		goto invalid;
 	}
 
-	if (evt_type & LE_EXT_ADV_CONN_IND) {
-		if (evt_type & LE_EXT_ADV_DIRECT_IND)
+	if (pdu_type & LE_EXT_ADV_CONN_IND) {
+		if (pdu_type & LE_EXT_ADV_DIRECT_IND)
 			return LE_ADV_DIRECT_IND;
 
 		return LE_ADV_IND;
 	}
 
-	if (evt_type & LE_EXT_ADV_SCAN_RSP)
+	if (pdu_type & LE_EXT_ADV_SCAN_RSP)
 		return LE_ADV_SCAN_RSP;
 
-	if (evt_type & LE_EXT_ADV_SCAN_IND)
+	if (pdu_type & LE_EXT_ADV_SCAN_IND)
 		return LE_ADV_SCAN_IND;
 
-	if (evt_type == LE_EXT_ADV_NON_CONN_IND ||
-	    evt_type & LE_EXT_ADV_DIRECT_IND)
+	if (pdu_type == LE_EXT_ADV_NON_CONN_IND ||
+	    pdu_type & LE_EXT_ADV_DIRECT_IND)
 		return LE_ADV_NONCONN_IND;
 
 invalid:
-- 
2.49.0


