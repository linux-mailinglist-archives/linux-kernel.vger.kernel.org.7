Return-Path: <linux-kernel+bounces-805655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53704B48C00
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 13:22:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24F7A3AB860
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 11:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D54A02FF652;
	Mon,  8 Sep 2025 11:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="odWqPKog"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123942E92D9
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 11:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757330217; cv=none; b=Z3fuNJ5K/j2eN88kQCwuBHEMzPlcPGl7kL5VACmCvUTnoZpCc3hzjPtGv7pRByVbNWTEf1idQfOMIzI5joGUzldRNCFgIvRlDdvLEcBSQxIWziX5p2gOIho5SWX7M/GHbePwt2K3Q4LS5tcDgFo7SZ8viGaZ5GiiMq0opP9TQIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757330217; c=relaxed/simple;
	bh=cfWhoISSKUd4/HPy52q/po+E/bDHAKEDdFs6svXqglY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FnfT1cRmfsgQV4UzxAQp383tYhpczImPbvAquHyYfirllA3+s7Ve6MMlDbA1E7gNjFZGiwlur8nOcJ4p3Pee6svAtvDEGYkS55dJfcUak2CNBMEubtB+Vs/fHT2GS0b4VGL6rmtEO3Y5TDv+JNJ+4a2uKL6R6qFSUe0+swOCdiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=odWqPKog; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5608d792558so4804457e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 04:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1757330213; x=1757935013; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CvMgIa6NfN/+40OPhd/GGuBzxDir3sztObXR4PANXWM=;
        b=odWqPKog0hHfgpHoI++l2bLBVb1rrGI4+MqmAcCi7lx8KF2NZ19BqzeCwHu2Xtyjdp
         dG76eCcGIjwAeepyvSUIC7H9yq1guEpj5ZZ2E9SiCARqftz4fD7sMj6GOltEAuRF4v50
         HpXxTUsS1F5Aan9rfm0xd6yjwo2K6IS7JR7Kw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757330213; x=1757935013;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CvMgIa6NfN/+40OPhd/GGuBzxDir3sztObXR4PANXWM=;
        b=FI2UgXwFlUrhKRx0tN/xI+oMHvokgbCJCU4HoI8K15375Qg9k8nSvPcyHlqo7lsquU
         xhSE6aKs2LtQig7v+jqJ5jgA7lmZCvJVWjES3YHNfCkFVYr9cC+Cply9Da4hw+7C0EbT
         YVjfF8WdAea/a1YECeCtggDNun7x/pBi1GYGWIvM4hfxqc/1tKTI9uS67hT8uRKoeUm6
         tymulaK/JEpXRXvyix4j9XSxa2AFozbMTo9ZT9upSx59iYFRQmPFYaxmmmB9yKJva1QD
         mma/wcITtH3vCg/n9uHrEclpsee5eaDHIKIdzdiTA5iashIPuDGnmN5v1dbSFxUz6mrv
         Olnw==
X-Forwarded-Encrypted: i=1; AJvYcCWpSqX4zvl9IBhxUW65qH1JLXOwBavkfds2S47kYQ3kUrTyh2CuCVgdSRI6Tw2Fd7ZZFhkDI+BHy1S9/dA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+9gHMD5Y6xFVYlH7fnE2mqbTXhsaQWLOo77CGjEJADy/2q/yo
	dgQpu4gqdKZWprTLISimMDTJU5bovS0XG4Ksvopq+NwcmaV22FR6Px/n7d8PvUhBrvgiB3oBkZA
	d/uA=
X-Gm-Gg: ASbGnctweiR7BaOQzhRpoOXt1CQx9obeExqfn28+kJZ/2EYlvPN1Sa6T5MqC1fjsRXf
	EP39zcuA8yhMoUffEavkJsjyBYnCegS0ea1CpZOpNHNEtOWUG/YHm+saabPIcmUz02inMNyxkz7
	PpXw4c33EAkC5FcnzCsAkigYJdCsBjZYv5NE4S3szc0ZAwcspPVxjo10XHdWOolvXUzCZ9wjoVn
	xg29unDtjZUoRJmH8Tml8DI1huuTWgpEww5N+Cb2U9AIJIZ9lBGCpd32XqP2achDzJtF05sfuSj
	3xc4YA0nnZfSOYIHn52sez/qte6j4I6cU5eWlf6XTg50hMlrtuOK9c4m4wkxHkbM4g8svJLlcXN
	Fd37NUXSoWVsB7mN/iwjD5vyZbqEDqUdTosUlFk+vOXyI2ytsIxTv0E2yI8ey/YEd88hY3QY=
X-Google-Smtp-Source: AGHT+IEj9CoYwU2/9FDUnkuGyyeJjE4N8m3JiDNba90PHqUtdXtllkptSWkxX4nM5sXo8r2JC4ghqA==
X-Received: by 2002:a05:6512:ea0:b0:55f:4b12:755b with SMTP id 2adb3069b0e04-5625f53609amr1840717e87.20.1757330212919;
        Mon, 08 Sep 2025 04:16:52 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5608ad44dc3sm3471806e87.135.2025.09.08.04.16.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 04:16:52 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5608d792558so4804414e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 04:16:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVf6HyGHryRDjZxBlCGZ+Eww8OrUC9rZJHu66M/K+T6+60z0YIsHfvpwy+0KLc7uHfVjynFfktCxiNsVTk=@vger.kernel.org
X-Received: by 2002:a05:6512:3b0c:b0:55f:43ff:9a3c with SMTP id
 2adb3069b0e04-5626219494fmr2120190e87.57.1757330210831; Mon, 08 Sep 2025
 04:16:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250714-uvc-racemeta-v1-1-360de2e15a9a@chromium.org>
 <20250908102532.GC26062@pendragon.ideasonboard.com> <CANiDSCsFCADj9NHURG8FV-1mTj8XhtksEqtk75-i3C3e6YyXUQ@mail.gmail.com>
In-Reply-To: <CANiDSCsFCADj9NHURG8FV-1mTj8XhtksEqtk75-i3C3e6YyXUQ@mail.gmail.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 8 Sep 2025 13:16:38 +0200
X-Gmail-Original-Message-ID: <CANiDSCuxMmD7M9XJLVmd1rRewqYqHq5WjtY4xgKggWBzsxn5Rw@mail.gmail.com>
X-Gm-Features: Ac12FXy6gFyE4Yc92qPG5qcDG7hibk6B9s1zcf6lKd5iwGt2IuCqWJomMhM-jFM
Message-ID: <CANiDSCuxMmD7M9XJLVmd1rRewqYqHq5WjtY4xgKggWBzsxn5Rw@mail.gmail.com>
Subject: Re: [PATCH] media: uvcvideo: Fix race condition for meta buffer list
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Hans de Goede <hansg@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 8 Sept 2025 at 12:57, Ricardo Ribalda <ribalda@chromium.org> wrote:
>
> Hi Laurent
>
> On Mon, 8 Sept 2025 at 12:25, Laurent Pinchart
> <laurent.pinchart@ideasonboard.com> wrote:
> >
> > Hi Ricardo,
> >
> > Thank you for the patch.
> >
> > On Mon, Jul 14, 2025 at 10:23:45AM +0000, Ricardo Ribalda wrote:
> > > queue->irqueue contains a list of the buffers owned by the driver. The
> > > list is protected by queue->irqlock. uvc_queue_get_current_buffer()
> > > returns a pointer to the current buffer in that list, but does not
> > > remove the buffer from it. This can lead to race conditions.
> > >
> > > Inspecting the code, it seems that the candidate for such race is
> > > uvc_queue_return_buffers(). For the capture queue, that function is
> > > called with the device streamoff, so no race can occur. On the other
> > > hand, the metadata queue, could trigger a race condition, because
> > > stop_streaming can be called with the device in any streaming state.
> > >
> > > We can solve this issue modifying the way the metadata buffer
> > > lifetime works. We can keep the queue->irqlock while the use the current
> > > metadata buffer.
> > >
> > > The core of this change is uvc_video_decode_meta(), it now obtains the
> > > buffer and holds the spinlock instead of getting the buffer as an
> > > argument.
> > >
> > > Reported-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > > Closes: https://lore.kernel.org/linux-media/20250630141707.GG20333@pendragon.ideasonboard.com/
> > > Cc: stable@vger.kernel.org
> > > Fixes: 088ead255245 ("media: uvcvideo: Add a metadata device node")
> > > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > > ---
> > >  drivers/media/usb/uvc/uvc_isight.c |  3 +-
> > >  drivers/media/usb/uvc/uvc_queue.c  |  4 +-
> > >  drivers/media/usb/uvc/uvc_video.c  | 92 ++++++++++++++++++++++----------------
> > >  drivers/media/usb/uvc/uvcvideo.h   |  8 ++--
> > >  4 files changed, 62 insertions(+), 45 deletions(-)
> > >
> > > diff --git a/drivers/media/usb/uvc/uvc_isight.c b/drivers/media/usb/uvc/uvc_isight.c
> > > index 43cda5e760a345af56186603e2f0594b814cdbcb..f0e71744d25cab98184335b46569b31ba1346e12 100644
> > > --- a/drivers/media/usb/uvc/uvc_isight.c
> > > +++ b/drivers/media/usb/uvc/uvc_isight.c
> > > @@ -98,8 +98,7 @@ static int isight_decode(struct uvc_video_queue *queue, struct uvc_buffer *buf,
> > >       return 0;
> > >  }
> > >
> > > -void uvc_video_decode_isight(struct uvc_urb *uvc_urb, struct uvc_buffer *buf,
> > > -                     struct uvc_buffer *meta_buf)
> > > +void uvc_video_decode_isight(struct uvc_urb *uvc_urb, struct uvc_buffer *buf)
> > >  {
> > >       struct urb *urb = uvc_urb->urb;
> > >       struct uvc_streaming *stream = uvc_urb->stream;
> > > diff --git a/drivers/media/usb/uvc/uvc_queue.c b/drivers/media/usb/uvc/uvc_queue.c
> > > index 790184c9843d211d34fa7d66801631d5a07450bd..e184e3ae0f59f142a683263168724bca64509628 100644
> > > --- a/drivers/media/usb/uvc/uvc_queue.c
> > > +++ b/drivers/media/usb/uvc/uvc_queue.c
> > > @@ -310,9 +310,11 @@ void uvc_queue_cancel(struct uvc_video_queue *queue, int disconnect)
> > >   * Buffers may span multiple packets, and even URBs, therefore the active buffer
> > >   * remains on the queue until the EOF marker.
> > >   */
> > > -static struct uvc_buffer *
> > > +struct uvc_buffer *
> > >  __uvc_queue_get_current_buffer(struct uvc_video_queue *queue)
> > >  {
> > > +     lockdep_assert_held(&queue->irqlock);
> > > +
> > >       if (list_empty(&queue->irqqueue))
> > >               return NULL;
> > >
> > > diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
> > > index 2e377e7b9e81599aca19b800a171cc16a09c1e8a..d6777090d0f892ffe93696c915acd4ec171ca798 100644
> > > --- a/drivers/media/usb/uvc/uvc_video.c
> > > +++ b/drivers/media/usb/uvc/uvc_video.c
> > > @@ -1428,9 +1428,11 @@ static int uvc_video_encode_data(struct uvc_streaming *stream,
> > >   * previous header.
> > >   */
> > >  static void uvc_video_decode_meta(struct uvc_streaming *stream,
> > > -                               struct uvc_buffer *meta_buf,
> > >                                 const u8 *mem, unsigned int length)
> > >  {
> > > +     struct vb2_queue *vb2_qmeta = stream->meta.vdev.queue;
> > > +     struct uvc_video_queue *qmeta = &stream->meta.queue;
> > > +     struct uvc_buffer *meta_buf;
> > >       struct uvc_meta_buf *meta;
> > >       size_t len_std = 2;
> > >       bool has_pts, has_scr;
> > > @@ -1439,7 +1441,13 @@ static void uvc_video_decode_meta(struct uvc_streaming *stream,
> > >       ktime_t time;
> > >       const u8 *scr;
> > >
> > > -     if (!meta_buf || length == 2)
> > > +     if (!vb2_qmeta || length <= 2)
> > > +             return;
> > > +
> > > +     guard(spinlock_irqsave)(&qmeta->irqlock);
> >
> > This keeps the spinlock held for longer than I would like. We should
> > really try to minimize the amount of work performed with a spinlock
> > held.
>
> We are using meta_buf the whole function, which can disappear if  the
> user closes the metadata file descriptor.
>
> Besides memcopying meta_buf, how would you suggest reducing the
> spinlock held time?

Actually, it can be slightly improved....

But I am not sure if holding and releasing the spinlock twice will be
any better....


Let me know if you prefer the previous version or this one.

Regards

diff --git a/drivers/media/usb/uvc/uvc_video.c
b/drivers/media/usb/uvc/uvc_video.c
index 178f1e40c189..fa96789e6089 100644
--- a/drivers/media/usb/uvc/uvc_video.c
+++ b/drivers/media/usb/uvc/uvc_video.c
@@ -1430,11 +1430,12 @@ static void uvc_video_decode_meta(struct
uvc_streaming *stream,
        if (!vb2_qmeta || length <= 2)
                return;

-       guard(spinlock_irqsave)(&qmeta->irqlock);
-
-       meta_buf = __uvc_queue_get_current_buffer(qmeta);
-       if (!meta_buf)
+       spin_lock_irq(&qmeta->irqlock);
+       if (list_empty(qmeta->irqqueue)) {
+               spin_unlock_irq(&qmeta->irqlock);
                return;
+       }
+       spin_unlock_irq(&qmeta->irqlock);

        has_pts = mem[1] & UVC_STREAM_PTS;
        has_scr = mem[1] & UVC_STREAM_SCR;
@@ -1456,27 +1457,38 @@ static void uvc_video_decode_meta(struct
uvc_streaming *stream,
                                  !memcmp(scr, stream->clock.last_scr, 6)))
                return;

+       if (has_scr)
+               memcpy(stream->clock.last_scr, scr, 6);
+
+       local_irq_save(flags);
+       time = uvc_video_get_time();
+       sof = usb_get_current_frame_number(stream->dev->udev);
+       local_irq_restore(flags);
+
+       spin_lock_irq(&qmeta->irqlock);
+
+       meta_buf = __uvc_queue_get_current_buffer(qmeta);
+       if (!meta_buf) {
+               spin_unlock_irq(&qmeta->irqlock);
+               return;
+       }
+
        if (meta_buf->length - meta_buf->bytesused <
            length + sizeof(meta->ns) + sizeof(meta->sof)) {
                meta_buf->error = 1;
+               spin_unlock_irq(&qmeta->irqlock);
                return;
        }

        meta = (struct uvc_meta_buf *)((u8 *)meta_buf->mem +
meta_buf->bytesused);
-       local_irq_save(flags);
-       time = uvc_video_get_time();
-       sof = usb_get_current_frame_number(stream->dev->udev);
-       local_irq_restore(flags);
        put_unaligned(ktime_to_ns(time), &meta->ns);
        put_unaligned(sof, &meta->sof);

-       if (has_scr)
-               memcpy(stream->clock.last_scr, scr, 6);
-
        meta->length = mem[0];
        meta->flags  = mem[1];
        memcpy(meta->buf, &mem[2], length - 2);
        meta_buf->bytesused += length + sizeof(meta->ns) + sizeof(meta->sof);
+       spin_unlock_irq(&qmeta->irqlock);

        uvc_dbg(stream->dev, FRAME,
                "%s(): t-sys %lluns, SOF %u, len %u, flags 0x%x, PTS
%u, STC %u frame SOF %u\n",



>
> Regards!
>
>
> >
> > > +
> > > +     meta_buf = __uvc_queue_get_current_buffer(qmeta);
> > > +     if (!meta_buf)
> > >               return;
> > >
> > >       has_pts = mem[1] & UVC_STREAM_PTS;
> > > @@ -1512,30 +1520,48 @@ static void uvc_video_validate_buffer(const struct uvc_streaming *stream,
> > >   * Completion handler for video URBs.
> > >   */
> > >
> > > -static void uvc_video_next_buffers(struct uvc_streaming *stream,
> > > -             struct uvc_buffer **video_buf, struct uvc_buffer **meta_buf)
> > > +static void uvc_video_next_meta(struct uvc_streaming *stream,
> > > +                             struct uvc_buffer *video_buf)
> > >  {
> > > -     uvc_video_validate_buffer(stream, *video_buf);
> > > +     struct vb2_queue *vb2_qmeta = stream->meta.vdev.queue;
> > > +     struct uvc_video_queue *qmeta = &stream->meta.queue;
> > > +     struct uvc_buffer *meta_buf;
> > > +     struct vb2_v4l2_buffer *vb2_meta;
> > > +     const struct vb2_v4l2_buffer *vb2_video;
> > >
> > > -     if (*meta_buf) {
> > > -             struct vb2_v4l2_buffer *vb2_meta = &(*meta_buf)->buf;
> > > -             const struct vb2_v4l2_buffer *vb2_video = &(*video_buf)->buf;
> > > +     if (!vb2_qmeta)
> > > +             return;
> > >
> > > -             vb2_meta->sequence = vb2_video->sequence;
> > > -             vb2_meta->field = vb2_video->field;
> > > -             vb2_meta->vb2_buf.timestamp = vb2_video->vb2_buf.timestamp;
> > > +     guard(spinlock_irqsave)(&qmeta->irqlock);
> > >
> > > -             (*meta_buf)->state = UVC_BUF_STATE_READY;
> > > -             if (!(*meta_buf)->error)
> > > -                     (*meta_buf)->error = (*video_buf)->error;
> > > -             *meta_buf = uvc_queue_next_buffer(&stream->meta.queue,
> > > -                                               *meta_buf);
> > > -     }
> > > -     *video_buf = uvc_queue_next_buffer(&stream->queue, *video_buf);
> > > +     meta_buf = __uvc_queue_get_current_buffer(qmeta);
> > > +     if (!meta_buf)
> > > +             return;
> > > +     list_del(&meta_buf->queue);
> > > +
> > > +     vb2_meta = &meta_buf->buf;
> > > +     vb2_video = &video_buf->buf;
> > > +
> > > +     vb2_meta->sequence = vb2_video->sequence;
> > > +     vb2_meta->field = vb2_video->field;
> > > +     vb2_meta->vb2_buf.timestamp = vb2_video->vb2_buf.timestamp;
> > > +     meta_buf->state = UVC_BUF_STATE_READY;
> > > +     if (!meta_buf->error)
> > > +             meta_buf->error = video_buf->error;
> > > +
> > > +     uvc_queue_buffer_release(meta_buf);
> > > +}
> > > +
> > > +static struct uvc_buffer *uvc_video_next_buffer(struct uvc_streaming *stream,
> > > +                                             struct uvc_buffer *video_buf)
> > > +{
> > > +     uvc_video_validate_buffer(stream, video_buf);
> > > +     uvc_video_next_meta(stream, video_buf);
> > > +     return uvc_queue_next_buffer(&stream->queue, video_buf);
> > >  }
> > >
> > >  static void uvc_video_decode_isoc(struct uvc_urb *uvc_urb,
> > > -                     struct uvc_buffer *buf, struct uvc_buffer *meta_buf)
> > > +                               struct uvc_buffer *buf)
> > >  {
> > >       struct urb *urb = uvc_urb->urb;
> > >       struct uvc_streaming *stream = uvc_urb->stream;
> > > @@ -1559,13 +1585,13 @@ static void uvc_video_decode_isoc(struct uvc_urb *uvc_urb,
> > >                       ret = uvc_video_decode_start(stream, buf, mem,
> > >                               urb->iso_frame_desc[i].actual_length);
> > >                       if (ret == -EAGAIN)
> > > -                             uvc_video_next_buffers(stream, &buf, &meta_buf);
> > > +                             buf = uvc_video_next_buffer(stream, buf);
> > >               } while (ret == -EAGAIN);
> > >
> > >               if (ret < 0)
> > >                       continue;
> > >
> > > -             uvc_video_decode_meta(stream, meta_buf, mem, ret);
> > > +             uvc_video_decode_meta(stream, mem, ret);
> > >
> > >               /* Decode the payload data. */
> > >               uvc_video_decode_data(uvc_urb, buf, mem + ret,
> > > @@ -1576,12 +1602,12 @@ static void uvc_video_decode_isoc(struct uvc_urb *uvc_urb,
> > >                       urb->iso_frame_desc[i].actual_length);
> > >
> > >               if (buf->state == UVC_BUF_STATE_READY)
> > > -                     uvc_video_next_buffers(stream, &buf, &meta_buf);
> > > +                     buf = uvc_video_next_buffer(stream, buf);
> > >       }
> > >  }
> > >
> > >  static void uvc_video_decode_bulk(struct uvc_urb *uvc_urb,
> > > -                     struct uvc_buffer *buf, struct uvc_buffer *meta_buf)
> > > +                               struct uvc_buffer *buf)
> > >  {
> > >       struct urb *urb = uvc_urb->urb;
> > >       struct uvc_streaming *stream = uvc_urb->stream;
> > > @@ -1607,7 +1633,7 @@ static void uvc_video_decode_bulk(struct uvc_urb *uvc_urb,
> > >               do {
> > >                       ret = uvc_video_decode_start(stream, buf, mem, len);
> > >                       if (ret == -EAGAIN)
> > > -                             uvc_video_next_buffers(stream, &buf, &meta_buf);
> > > +                             buf = uvc_video_next_buffer(stream, buf);
> > >               } while (ret == -EAGAIN);
> > >
> > >               /* If an error occurred skip the rest of the payload. */
> > > @@ -1617,7 +1643,7 @@ static void uvc_video_decode_bulk(struct uvc_urb *uvc_urb,
> > >                       memcpy(stream->bulk.header, mem, ret);
> > >                       stream->bulk.header_size = ret;
> > >
> > > -                     uvc_video_decode_meta(stream, meta_buf, mem, ret);
> > > +                     uvc_video_decode_meta(stream, mem, ret);
> > >
> > >                       mem += ret;
> > >                       len -= ret;
> > > @@ -1644,7 +1670,7 @@ static void uvc_video_decode_bulk(struct uvc_urb *uvc_urb,
> > >                       uvc_video_decode_end(stream, buf, stream->bulk.header,
> > >                               stream->bulk.payload_size);
> > >                       if (buf->state == UVC_BUF_STATE_READY)
> > > -                             uvc_video_next_buffers(stream, &buf, &meta_buf);
> > > +                             buf = uvc_video_next_buffer(stream, buf);
> > >               }
> > >
> > >               stream->bulk.header_size = 0;
> > > @@ -1654,7 +1680,7 @@ static void uvc_video_decode_bulk(struct uvc_urb *uvc_urb,
> > >  }
> > >
> > >  static void uvc_video_encode_bulk(struct uvc_urb *uvc_urb,
> > > -     struct uvc_buffer *buf, struct uvc_buffer *meta_buf)
> > > +                               struct uvc_buffer *buf)
> > >  {
> > >       struct urb *urb = uvc_urb->urb;
> > >       struct uvc_streaming *stream = uvc_urb->stream;
> > > @@ -1707,8 +1733,6 @@ static void uvc_video_complete(struct urb *urb)
> > >       struct uvc_video_queue *qmeta = &stream->meta.queue;
> > >       struct vb2_queue *vb2_qmeta = stream->meta.vdev.queue;
> > >       struct uvc_buffer *buf = NULL;
> > > -     struct uvc_buffer *buf_meta = NULL;
> > > -     unsigned long flags;
> > >       int ret;
> > >
> > >       switch (urb->status) {
> > > @@ -1734,14 +1758,6 @@ static void uvc_video_complete(struct urb *urb)
> > >
> > >       buf = uvc_queue_get_current_buffer(queue);
> > >
> > > -     if (vb2_qmeta) {
> > > -             spin_lock_irqsave(&qmeta->irqlock, flags);
> > > -             if (!list_empty(&qmeta->irqqueue))
> > > -                     buf_meta = list_first_entry(&qmeta->irqqueue,
> > > -                                                 struct uvc_buffer, queue);
> > > -             spin_unlock_irqrestore(&qmeta->irqlock, flags);
> > > -     }
> > > -
> > >       /* Re-initialise the URB async work. */
> > >       uvc_urb->async_operations = 0;
> > >
> > > @@ -1755,7 +1771,7 @@ static void uvc_video_complete(struct urb *urb)
> > >        * Process the URB headers, and optionally queue expensive memcpy tasks
> > >        * to be deferred to a work queue.
> > >        */
> > > -     stream->decode(uvc_urb, buf, buf_meta);
> > > +     stream->decode(uvc_urb, buf);
> > >
> > >       /* If no async work is needed, resubmit the URB immediately. */
> > >       if (!uvc_urb->async_operations) {
> > > diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
> > > index 757254fc4fe930ae61c9d0425f04d4cd074a617e..bb41477ce4ff5cdbf27bc9d830b63a60645e3fa1 100644
> > > --- a/drivers/media/usb/uvc/uvcvideo.h
> > > +++ b/drivers/media/usb/uvc/uvcvideo.h
> > > @@ -479,8 +479,7 @@ struct uvc_streaming {
> > >       unsigned int frozen : 1;
> > >       struct uvc_video_queue queue;
> > >       struct workqueue_struct *async_wq;
> > > -     void (*decode)(struct uvc_urb *uvc_urb, struct uvc_buffer *buf,
> > > -                    struct uvc_buffer *meta_buf);
> > > +     void (*decode)(struct uvc_urb *uvc_urb, struct uvc_buffer *buf);
> > >
> > >       struct {
> > >               struct video_device vdev;
> > > @@ -694,6 +693,8 @@ int uvc_queue_init(struct uvc_video_queue *queue, enum v4l2_buf_type type);
> > >  void uvc_queue_cancel(struct uvc_video_queue *queue, int disconnect);
> > >  struct uvc_buffer *uvc_queue_next_buffer(struct uvc_video_queue *queue,
> > >                                        struct uvc_buffer *buf);
> > > +struct uvc_buffer *
> > > +__uvc_queue_get_current_buffer(struct uvc_video_queue *queue);
> > >  struct uvc_buffer *uvc_queue_get_current_buffer(struct uvc_video_queue *queue);
> > >  void uvc_queue_buffer_release(struct uvc_buffer *buf);
> > >  static inline int uvc_queue_streaming(struct uvc_video_queue *queue)
> > > @@ -802,8 +803,7 @@ u16 uvc_endpoint_max_bpi(struct usb_device *dev, struct usb_host_endpoint *ep);
> > >
> > >  /* Quirks support */
> > >  void uvc_video_decode_isight(struct uvc_urb *uvc_urb,
> > > -                          struct uvc_buffer *buf,
> > > -                          struct uvc_buffer *meta_buf);
> > > +                          struct uvc_buffer *buf);
> > >
> > >  /* debugfs and statistics */
> > >  void uvc_debugfs_init(void);
> > >
> > > ---
> > > base-commit: d968e50b5c26642754492dea23cbd3592bde62d8
> > > change-id: 20250714-uvc-racemeta-fee2e69bbfcd
> >
> > --
> > Regards,
> >
> > Laurent Pinchart
>
>
>
> --
> Ricardo Ribalda



-- 
Ricardo Ribalda

